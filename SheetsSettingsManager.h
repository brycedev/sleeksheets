@interface SheetsSettingsManager : NSObject

@property (nonatomic, copy) NSDictionary *settings;

@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL squareCorners;
@property (nonatomic, readonly) BOOL flushEdges;
@property (nonatomic, readonly) BOOL hideActionSeparators;
@property (nonatomic, readonly) BOOL hideCancelAction;

+ (instancetype)sharedManager;
- (void)updateSettings;

@end
