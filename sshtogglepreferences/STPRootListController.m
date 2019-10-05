#include "STPRootListController.h"

@implementation STPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)openGithubRepo {
    [[UIApplication sharedApplication]
        openURL:[NSURL URLWithString:@"https://github.com/Praseetha-KR/sshtoggle"]
        options:@{}
        completionHandler:nil];
}

@end
