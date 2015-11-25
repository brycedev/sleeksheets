#include "SheetsConfigurationController.h"

@implementation SheetsConfigurationController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Configuration" target:self] retain];
	}

	return _specifiers;
}

@end
