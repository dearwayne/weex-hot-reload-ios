//
//  WXBaseViewController+category.m
//  WeexSDK
//
//  Created by wayne on 2019/7/26.
//

#import "WXBaseViewController+category.h"
#import <objc/runtime.h>
#import "HRWeexHotReload.h"
#import "HRSocketManager.h"

@implementation WXBaseViewController (category)

+ (void)install {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method = class_getInstanceMethod([self class], @selector(initWithSourceURL:));
        Method swapMethod = class_getInstanceMethod([self class], @selector(swap_initWithSourceURL:));
        if (method && swapMethod) {
            method_exchangeImplementations(method, swapMethod);
        }
    });
}

- (instancetype)swap_initWithSourceURL:(NSURL *)sourceURL {
    [self swap_initWithSourceURL:sourceURL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(renderhWeex)
                                                 name:@"RefreshInstance"
                                               object:nil];
    [[HRSocketManager shared] connectWithUrl:[self urlToSocketURL:sourceURL]];
    return self;
}

- (void)renderhWeex {
    if ([HRWeexHotReload manager].enabled) {
        [self refreshWeex];
    }
}

- (NSURL *)urlToSocketURL:(NSURL *) sourceUrl {
    NSString *host = [sourceUrl host];
    NSInteger port = [[sourceUrl port] integerValue];
    if (port <= 0) {
        port = 80;
    }
    NSMutableString *socketUrl = [NSMutableString stringWithFormat:@"ws://%@:%ld/sockjs-node/websocket",host,(long)port];
    return [NSURL URLWithString:socketUrl];
}
@end
