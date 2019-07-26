//
//  HRSocketManager.h
//  Pods-WeexHotReload_Example
//
//  Created by wayne on 2019/7/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HRSocketManager : NSObject

+ (instancetype)shared;
- (void)connectWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
