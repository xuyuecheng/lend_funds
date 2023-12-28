//
//  CZDeviceInfoUtils.h
//  Runner
//
//  Created by 陈浩 on 2023/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZDeviceInfoUtils : NSObject

+ (instancetype)sharedManager;

+ (NSDictionary*) getDeviceInfo;
@end

NS_ASSUME_NONNULL_END
