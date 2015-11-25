#import <Cephei/HBPreferences.h>

#define APPID "com.brycedev.sleeksheets"

HBPreferences *prefs;

%hook UIAlertControllerVisualStyleActionSheet

- (float)backgroundCornerRadius {
	if([prefs boolForKey:@"enabled"] && [prefs boolForKey:@"squareCorners"])
		return 0.0;
	return %orig;
}

- (UIEdgeInsets)contentInsets {
	if([prefs boolForKey:@"enabled"] && [prefs boolForKey:@"flushEdges"])
		return UIEdgeInsetsZero;
	return %orig;
}

- (BOOL)hideActionSeparators {
	if([prefs boolForKey:@"enabled"] && [prefs boolForKey:@"hideActionSeparators"])
		return YES;
	return %orig;
}

- (BOOL)hideCancelAction:(id)action inAlertController:(UIAlertController *)controller {
	if([prefs boolForKey:@"enabled"] && [prefs boolForKey:@"hideCancelAction"])
		return YES;
	return %orig;
}

%end

%ctor {
	dlopen("/Library/MobileSubstrate/DynamicLibraries/Roundification.dylib", RTLD_NOW);
	prefs = [[HBPreferences alloc] initWithIdentifier: @"com.brycedev.sleeksheets"];
	[prefs registerDefaults:@{
		@"enabled"              : @YES,
		@"squareCorners"        : @YES,
		@"flushEdges"           : @YES,
		@"hideActionSeparators" : @YES,
		@"hideCancelAction"     : @YES
	}];
}
