//
//  CZDeviceUtils.h
//  Runner
//
//  Created by 陈浩 on 2023/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZDeviceUtils : NSObject

+ (instancetype)sharedManager;

- (void)getDeviceInfo;

@end

NS_ASSUME_NONNULL_END
