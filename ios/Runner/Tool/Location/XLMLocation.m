//
//  XLMLocation.m
//  JPStudy
//
//  Created by  on 2018/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "XLMLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface XLMLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
// 地理编码和反编码
@property (strong, nonatomic) CLGeocoder *geocoder;
/** 所有定位信息 */
@property (copy, nonatomic) LocationPlacemark locationPlacemark;
/** 定位失败 */
@property (copy, nonatomic) LocationFailed locationFailed;
/** 定位状态 */
@property (copy, nonatomic) LocationStatus locationStatus;

@property (nonatomic) NSInteger tryCount;



@end

@implementation XLMLocation

//单例
+ (instancetype)shareInstance {
    static XLMLocation *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[XLMLocation alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _tryCount = 0;
    }
    return self;
}

#pragma mark 设置开启定位
- (void)getLocationPlacemark:(LocationPlacemark)placemark status:(LocationStatus)status didFailWithError:(LocationFailed)error
{
    
    if (placemark) {
        self.locationPlacemark = placemark;
    }
    
    if (status) {
        self.locationStatus = status;
    }
    
    if (error) {
        self.locationFailed = error;
    }
    
    
    [self startPositioningSystem];
    
}

- (void)startPositioningSystem
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    self.locationManager.distanceFilter = kCLLocationAccuracyThreeKilometers;
    [self.locationManager startUpdatingLocation];
    // 初始化编码器
    self.geocoder = [CLGeocoder new];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations[0];
    self.coordinate = location.coordinate;
    // 通常为了节省电量和资源损耗，在获取到位置以后选择停止定位服务
    [self.locationManager stopUpdatingLocation];
    // 地理反编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placeMark = placemarks[0];
        
        if (self.locationPlacemark) {
            self.locationPlacemark(placeMark);
            if([placeMark locality]){
                self.locatcity = [placeMark locality];
                self.placemark = placeMark;
            }
        }
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // 通常为了节省电量和资源损耗，在获取到位置以后选择停止定位服务
    [self.locationManager stopUpdatingLocation];
    if (self.locationFailed) {
        self.locationFailed(error);
        self.locatcity = @"定位失败";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"XLMLocationChangeNotification" object:nil];
    }
}

// 定位状态改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // 4.开始定位
    [self.locationManager startUpdatingLocation];
    if (self.locationStatus) {
        self.locationStatus(status);
        self.locatcity = @"定位中";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"XLMLocationChangeNotification" object:nil];
    }
}

@end
