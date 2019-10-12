#import "NSTask.h"


static void startSSH(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:
        [NSArray arrayWithObjects:
            @"-c",
            @"/usr/bin/sudo /bin/launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist",
            nil
        ]
    ];
    [task launch];
    [task waitUntilExit];

    NSLog(@"com.openssh.sshd loaded");
}

static void stopSSH(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:
        [NSArray arrayWithObjects:
            @"-c",
            @"/usr/bin/sudo /bin/launchctl unload /Library/LaunchDaemons/com.openssh.sshd.plist",
            nil
        ]
    ];
    [task launch];
    [task waitUntilExit];

    NSLog(@"com.openssh.sshd unnloaded");
}

int main(int argc, char *argv[], char *envp[]) {
    NSLog(@"sshtoggled is launched!");

    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL, startSSH,
        CFSTR("in.imagineer.sshtogglepreferences/sshswitch.on"),
        NULL, CFNotificationSuspensionBehaviorCoalesce
    );
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL, stopSSH,
        CFSTR("in.imagineer.sshtogglepreferences/sshswitch.off"),
        NULL, CFNotificationSuspensionBehaviorCoalesce
    );

    CFRunLoopRun(); // keep it running in background
    return 0;
}
