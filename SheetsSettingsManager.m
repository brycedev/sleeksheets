#import "SheetsSettingsManager.h"



@implementation SheetsSettingsManager

+ (instancetype)sharedManager {
    static dispatch_once_t p = 0;
    __strong static id _sharedSelf = nil;
    dispatch_once(&p, ^{
        _sharedSelf = [[self alloc] init];
    });
    return _sharedSelf;
}

void prefschanged(CFNotificationCenterRef center, void * observer, CFStringRef name, const void * object, CFDictionaryRef userInfo) {
    [[SheetsSettingsManager sharedManager] updateSettings];
}

- (id)init {
    if (self = [super init]) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, prefschanged, CFSTR("com.brycedev.sleeksheets.prefschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        [self updateSettings];
    }
    return self;
}

- (void)updateSettings {
    self.settings = nil;
    CFPreferencesAppSynchronize(CFSTR("com.brycedev.sleeksheets"));
    CFStringRef appID = CFSTR("com.brycedev.sleeksheets");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost) ?: CFArrayCreate(NULL, NULL, 0, NULL);
    self.settings = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFRelease(keyList);
    HBLogInfo(@"the settings : %@", self.settings);
}

- (BOOL)enabled {
    return self.settings[@"enabled"] ? [self.settings[@"enabled"] boolValue] : YES;
}

- (BOOL)squareCorners {
    return self.settings[@"squareCorners"] ? [self.settings[@"squareCorners"] boolValue] : YES;
}

- (BOOL)flushEdges {
    return self.settings[@"flushEdges"] ? [self.settings[@"flushEdges"] boolValue] : YES;
}

- (BOOL)hideActionSeparators {
    return self.settings[@"hideActionSeparators"] ? [self.settings[@"hideActionSeparators"] boolValue] : YES;
}

- (BOOL)hideCancelAction {
    return self.settings[@"hideCancelAction"] ? [self.settings[@"hideCancelAction"] boolValue] : YES;
}

@end
