#include <stdio.h>
#include <string.h>
#import "NSTask.h"

int main(int argc, char *argv[], char *envp[]) {
    if (argc < 2) {
        printf("Error: command missing\n");
        return 1;
    }
    setuid(0);

    NSTask *task = [[NSTask alloc] init];
    NSMutableArray *args = [[NSMutableArray alloc] init];

    if (!strcmp(argv[1], "0")) {
        [task setLaunchPath:@"/bin/sh"];
        [args addObject:@"-c"];
        [args addObject:@"/usr/bin/sudo /bin/launchctl unload /Library/LaunchDaemons/com.openssh.sshd.plist"];
    }
    else if (!strcmp(argv[1], "1")) {
        [task setLaunchPath:@"/bin/sh"];
        [args addObject:@"-c"];
        [args addObject:@"/usr/bin/sudo /bin/launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist"];
    }
    else {
        printf("Error: command not valid\n");
        return 1;
    }

    [task setArguments:args];
    [task launch];
    [task waitUntilExit];

    return 0;
}
