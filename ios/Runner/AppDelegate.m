#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "CZDeviceUtils.h"
#import <Branch.h>
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
