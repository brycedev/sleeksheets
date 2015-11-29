#define APPID "com.brycedev.sleeksheets"

static BOOL enabled;
static BOOL flushEdges;
static BOOL squareCorners;
static BOOL hideActionSeparators;
static BOOL hideCancelAction;

static NSDictionary *prefs = nil;

%hook UIAlertControllerVisualStyleActionSheet

- (float)backgroundCornerRadius {
	if(enabled && squareCorners)
		return 0.0;
	return %orig;
}

- (UIEdgeInsets)contentInsets {
	if(enabled && flushEdges)
		return UIEdgeInsetsZero;
	return %orig;
}

- (BOOL)hideActionSeparators {
	if(enabled && hideActionSeparators)
		return YES;
	return %orig;
}

- (BOOL)hideCancelAction:(id)action inAlertController:(UIAlertController *)controller {
	if(enabled && hideCancelAction)
		return YES;
	return %orig;
}

%end

static void reloadprefs(){
	if (prefs) {
		[prefs release];
		prefs = nil;
	}
	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR(APPID) , kCFPreferencesCurrentUser, kCFPreferencesAnyHost) ?: CFArrayCreate(NULL, NULL, 0, NULL);
	prefs = (NSDictionary *)CFPreferencesCopyMultiple(keyList, CFSTR(APPID) , kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	HBLogInfo(@"prefs : %@", prefs);
	enabled = [prefs objectForKey: @"enabled"] ? [[prefs objectForKey: @"enabled"] boolValue] : YES;
	hideCancelAction = [prefs objectForKey: @"hideCancelAction"] ? [[prefs objectForKey: @"hideCancelAction"] boolValue] : YES;
	squareCorners = [prefs objectForKey: @"squareCorners"] ? [[prefs objectForKey: @"squareCorners"] boolValue] : YES;
	hideActionSeparators = [prefs objectForKey: @"hideActionSeparators"] ? [[prefs objectForKey: @"hideActionSeparators"] boolValue] : YES;
	flushEdges = [prefs objectForKey: @"flushEdges"] ? [[prefs objectForKey: @"flushEdges"] boolValue] : YES;
}

static inline void prefschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	reloadprefs();
}

%ctor {
	dlopen("/Library/MobileSubstrate/DynamicLibraries/Roundification.dylib", RTLD_NOW);
	CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(r, NULL, prefschanged, CFSTR("com.brycedev.sleeksheets.prefschanged"), NULL, 0);
	reloadprefs();
}
