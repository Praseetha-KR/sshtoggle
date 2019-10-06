#import <spawn.h>

static bool isSSHEnabled = true;
static NSLock *lock;

static void UpdateSSHEnabledState(bool shouldEnable) {
    if(shouldEnable) {
        pid_t pid;
        int status;
        const char* argv[] = {"sh", "-c", "/usr/bin/sudo /bin/launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist", NULL};
        posix_spawn(&pid, "/bin/sh", NULL, NULL, (char* const*)argv, NULL);
        waitpid(pid, &status, WEXITED);
        NSLog(@"sshd loaded");
    } else {
        pid_t pid;
        int status;
        const char* argv[] = {"sh", "-c", "/usr/bin/sudo /bin/launchctl unload /Library/LaunchDaemons/com.openssh.sshd.plist", NULL};
        posix_spawn(&pid, "/bin/sh", NULL, NULL, (char* const*)argv, NULL);
        waitpid(pid, &status, WEXITED);
        NSLog(@"sshd unloaded");
    }
    isSSHEnabled = shouldEnable;
}


static void loadPrefs()
{
    CFPreferencesAppSynchronize(CFSTR("in.imagineer.sshtogglepreferences"));
    Boolean valid;
    bool enabled(CFPreferencesGetAppBooleanValue(CFSTR("isSSHEnabled"), CFSTR("in.imagineer.sshtogglepreferences"), &valid));

    isSSHEnabled = enabled;
    @synchronized (lock) {
        UpdateSSHEnabledState(isSSHEnabled);
    }
}

%ctor
{
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL, (CFNotificationCallback)loadPrefs,
        CFSTR("in.imagineer.sshtogglepreferences/preferences.changed"),
        NULL, CFNotificationSuspensionBehaviorCoalesce
    );
    lock = [[NSLock alloc] init];
    loadPrefs();
}
