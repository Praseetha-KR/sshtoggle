#import <notify.h>
#import "NSTask.h"


static bool isSSHEnabled = true;
static NSLock *lock;

static void UpdateSSHEnabledState(bool shouldEnable) {
    if(shouldEnable) {
        notify_post("in.imagineer.sshtogglepreferences/sshswitch.on");
    } else {
        notify_post("in.imagineer.sshtogglepreferences/sshswitch.off");
    }
    isSSHEnabled = shouldEnable;
}


static void loadPrefs()
{
    CFPreferencesAppSynchronize(CFSTR("in.imagineer.sshtogglepreferences"));

    Boolean keyExistsAndValid;
    Boolean enabled = CFPreferencesGetAppBooleanValue(CFSTR("isSSHEnabled"), CFSTR("in.imagineer.sshtogglepreferences"), &keyExistsAndValid);
    isSSHEnabled = enabled || !keyExistsAndValid;

    @synchronized (lock) {
        UpdateSSHEnabledState(isSSHEnabled);
    }
}

%ctor
{
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL, (CFNotificationCallback)loadPrefs,
        CFSTR("in.imagineer.sshtogglepreferences/sshswitch.changed"),
        NULL, CFNotificationSuspensionBehaviorCoalesce
    );
    lock = [[NSLock alloc] init];
    loadPrefs();
}
