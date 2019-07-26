//
//  HRWeexHotReload.h
//  WeexHotReload
//
//  Created by wayne on 2019/7/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HRWeexHotReload : NSObject

@property (nonatomic,assign) BOOL enabled;

+ (instancetype)manager;

@end

NS_ASSUME_NONNULL_END
