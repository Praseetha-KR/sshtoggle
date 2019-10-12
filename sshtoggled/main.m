#include <stdio.h>
#include <string.h>
#import <notify.h>
#import "NSTask.h"

static void StopSSH(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSTask *task = [[NSTask alloc] init];
    NSMutableArray *args = [[NSMutableArray alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [args addObject:@"-c"];
    [args addObject:@"/usr/bin/sudo /bin/launchctl unload /Library/LaunchDaemons/com.openssh.sshd.plist"];
    [task setArguments:args];
    [task launch];
    [task waitUntilExit];

    NSLog(@"sshd stopped");
}

static void StartSSH(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSTask *task = [[NSTask alloc] init];
    NSMutableArray *args = [[NSMutableArray alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [args addObject:@"-c"];
    [args addObject:@"/usr/bin/sudo /bin/launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist"];
    [task setArguments:args];
    [task launch];
    [task waitUntilExit];

    NSLog(@"sshd started");
}

int main(int argc, char *argv[], char *envp[]) {
    NSLog(@"sshtoggled is launched!");

	CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL, StartSSH,
        CFSTR("in.imagineer.sshtogglepreferences/preferences.ssh.on"),
        NULL, CFNotificationSuspensionBehaviorCoalesce
    );
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL, StopSSH,
        CFSTR("in.imagineer.sshtogglepreferences/preferences.ssh.off"),
        NULL, CFNotificationSuspensionBehaviorCoalesce
    );

	CFRunLoopRun(); // keep it running in background
	return 0;
}
