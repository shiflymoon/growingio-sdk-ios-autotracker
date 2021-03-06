//
// Created by xiangyang on 2020/11/10.
//

#import "GrowingConfigurationManager.h"
#import "GrowingTrackConfiguration.h"

@implementation GrowingConfigurationManager
@synthesize trackConfiguration = _trackConfiguration;
@synthesize urlScheme = _urlScheme;

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (void)setTrackConfiguration:(GrowingTrackConfiguration *)configuration {
    _trackConfiguration = [configuration copyWithZone:nil];
}

- (NSString *)urlScheme {
    if (_urlScheme == nil) {
        _urlScheme = [self getCurrentUrlScheme];
    }
    return _urlScheme;
}

- (NSString *)getCurrentUrlScheme {
    NSArray *urlSchemeGroup = [[NSBundle mainBundle] infoDictionary][@"CFBundleURLTypes"];
    for (NSDictionary *dic in urlSchemeGroup) {
        NSArray *shemes = dic[@"CFBundleURLSchemes"];
        for (NSString *urlScheme in shemes) {
            if ([urlScheme isKindOfClass:NSString.class] && [urlScheme hasPrefix:@"growing."]) {
                return urlScheme;
            }
        }
    }
    return nil;
}

@end