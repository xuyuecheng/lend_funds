//
//  XLMLocation.h
//  JPStudy
//
//  Created by  on 2018/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "XLMCityModel.h"

typedef void(^LocationPlacemark)(CLPlacemark *placemark);
typedef void(^LocationFailed)(NSError *error);
typedef void(^LocationStatus)(CLAuthorizationStatus status);

@interface XLMLocation : NSObject
//经纬度
@property (nonatomic, assign)CLLocationCoordinate2D  coordinate;
//定位城市
@property (nonatomic, copy) NSString *locatcity;

@property (nonatomic, strong) CLPlacemark *placemark;


//单例
+ (instancetype)shareInstance;
- (void)getLocationPlacemark:(LocationPlacemark)placemark status:(LocationStatus)status didFailWithError:(LocationFailed)error;

@end
