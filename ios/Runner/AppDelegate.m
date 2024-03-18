#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "CZDeviceUtils.h"
#import <Branch.h>
#import "XLMLocation.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    [[CZDeviceUtils sharedManager] getDeviceInfo];
    // Listener for Branch deep link data
     [[Branch getInstance] initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary * _Nonnull params, NSError * _Nullable error) {
         NSLog(@"11112222%@,userInfo:%@,code:%ld,domain:%@", params,error.userInfo,(long)error.code,error.domain);
           // Access and use deep link data here (nav to page, display content, etc.)
     }];
    [XLMLocation shareInstance];
    [[XLMLocation shareInstance] getLocationPlacemark:^(CLPlacemark *placemark) {
        NSString *locationStr = @"";
        NSLog(@"name:%@", placemark.name);
        NSLog(@"thoroughfare:%@", placemark.thoroughfare);//前埔路国金广场A1座14楼
        NSLog(@"subThoroughfare:%@", placemark.subThoroughfare);
        NSLog(@"locality:%@", placemark.locality);//厦门市
        NSLog(@"subLocality:%@", placemark.subLocality);//思明区
        NSLog(@"administrativeArea:%@", placemark.administrativeArea);//福建省
        NSLog(@"subAdministrativeArea:%@", placemark.subAdministrativeArea);
        NSLog(@"postalCode:%@", placemark.postalCode);
        NSLog(@"ISOcountryCode:%@", placemark.ISOcountryCode);
        NSLog(@"country:%@", placemark.country);//中国
        NSLog(@"inlandWater:%@", placemark.inlandWater);
        NSLog(@"ocean:%@", placemark.ocean);
        NSLog(@"areasOfInterest:%@", placemark.areasOfInterest);
        NSLog(@"latitude:%f", placemark.location.coordinate.latitude);//24.482124
        NSLog(@"longitude:%f", placemark.location.coordinate.longitude);//118.174066
    } status:^(CLAuthorizationStatus status) {
        
    } didFailWithError:^(NSError *error) {
        
    }];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  [[Branch getInstance] application:app openURL:url options:options];
  return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
  // Handler for Universal Links
  [[Branch getInstance] continueUserActivity:userActivity];
  return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  // Handler for Push Notifications
  [[Branch getInstance] handlePushNotification:userInfo];
}

@end
