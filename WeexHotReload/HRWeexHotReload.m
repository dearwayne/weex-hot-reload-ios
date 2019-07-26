//
//  HRWeexHotReload.m
//  WeexHotReload
//
//  Created by wayne on 2019/7/25.
//

#import "HRWeexHotReload.h"
#import <objc/runtime.h>
#import "WXBaseViewController+category.h"

@interface HRWeexHotReload()

@end

@implementation HRWeexHotReload

+ (void)load {
    [WXBaseViewController install];
}

static HRWeexHotReload *sharedInstance;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HRWeexHotReload alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    if (self = [super init]) {
        self.enabled = YES;
        [WXBaseViewController install];
    }
    return self;
}
@end
