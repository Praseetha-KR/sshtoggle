#import <spawn.h>
#import "NSTask.h"
#import <notify.h>

static bool isSSHEnabled = true;
static NSLock *lock;

NSString *runCommand(NSString *theCommand) { //run shell command as mobile and return the output. running a command as root can be seen in the "sourcecode-daemon" folder
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = pipe.fileHandleForReading;

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/bin/bash";
    task.arguments = @[@"-c", theCommand];
    task.standardOutput = pipe;
    [task launch];
    [task waitUntilExit];

    NSData *data = [file readDataToEndOfFile];
    [file closeFile];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

static void UpdateSSHEnabledState(bool shouldEnable) {
    if(shouldEnable) {
        // runCommand(@"sshtoggled 1");
        notify_post("in.imagineer.sshtogglepreferences/preferences.ssh.on");
        // int token;
        // notify_register_check("in.imagineer.sshtogd.preference", &token);
        // notify_set_state(token, 1);
        // notify_post("in.imagineer.sshtogd.preference");

        // pid_t pid;
        // int status;
        // const char* argv[] = {"sh", "-c", "/usr/bin/sudo /bin/launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist", NULL};
        // posix_spawn(&pid, "/bin/sh", NULL, NULL, (char* const*)argv, NULL);
        // waitpid(pid, &status, WEXITED);
        NSLog(@"sshd loaded");
    } else {
        // runCommand(@"sshtoggled 0");
        notify_post("in.imagineer.sshtogglepreferences/preferences.ssh.off");
        // int token;
        // notify_register_check("in.imagineer.sshtogd.preference", &token);
        // notify_set_state(token, 0);
        // notify_post("in.imagineer.sshtogd.preference");
        // pid_t pid;
        // int status;
        // const char* argv[] = {"sh", "-c", "/usr/bin/sudo /bin/launchctl unload /Library/LaunchDaemons/com.openssh.sshd.plist", NULL};
        // posix_spawn(&pid, "/bin/sh", NULL, NULL, (char* const*)argv, NULL);
        // waitpid(pid, &status, WEXITED);
        NSLog(@"sshd unloaded");
    }
    isSSHEnabled = shouldEnable;
}


static void loadPrefs()
{
    CFPreferencesAppSynchronize(CFSTR("in.imagineer.sshtogglepreferences"));
    Boolean keyExists;
    Boolean enabled = CFPreferencesGetAppBooleanValue(CFSTR("isSSHEnabled"), CFSTR("in.imagineer.sshtogglepreferences"), &keyExists);

    isSSHEnabled = enabled || !keyExists;
    @synchronized (lock) {
        // runCommand(@"/Library/sshtoggle/create.sh");
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
