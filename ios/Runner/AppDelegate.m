#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "CZDeviceUtils.h"
//#import <Branch.h>
#import "XLMLocation.h"
//#import <UserNotifications/UserNotifications.h>
//#import <FirebaseCore.h>
//#import <Singular.h>
//#import "Singular.h"
#import <Singular/Singular.h>
@implementation AppDelegate
//NSString *const kGCMMessageIDKey = @"gcm.message_id";
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    [[CZDeviceUtils sharedManager] getDeviceInfo];
    // Listener for Branch deep link data
//     [[Branch getInstance] initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary * _Nonnull params, NSError * _Nullable error) {
//         NSLog(@"11112222%@,userInfo:%@,code:%ld,domain:%@", params,error.userInfo,(long)error.code,error.domain);
//           // Access and use deep link data here (nav to page, display content, etc.)
//     }];
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
    
    // TODO: 等firebase ID申请下来后再打开注释
//    [FIRApp configure];
//    [FIRMessaging messaging].delegate = self;
//    //请求用户授权以发送本地和远程通知
//    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
//    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
//
//    [application registerForRemoteNotifications];
    
    // 如果会话超时已过/使用 Singular Link 打开，则当用户打开应用程序时启动新会话
                SingularConfig *config = [self getConfig];
                config.launchOptions = launchOptions;
                [Singular start:config];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (SingularConfig *)getConfig {
            NSLog(@"-- Scene Delegate getConfig");
            
            // 使用 SDK 密钥和 SDK Secret 创建配置对象
            SingularConfig* config = [[SingularConfig alloc] initWithApiKey:@"pt_finance_2_0c804da6" andSecret:@"382fdc1f2628aa6e23567d14d84dfb35"];
        
            /* 在初始化前设置 300 秒延迟，以等待用户的 ATT 响应。如果不显示 ATT 提示，请删除此项！*/
            config.waitForTrackingAuthorizationWithTimeoutInterval = 300;
        
            // 支持自定义 ESP 域名
            config.espDomains = @[@"links.your-website-domain.com"];
        
            // 为深层链接设置处理程序方法
            config.singularLinksHandler = ^(SingularLinkParams * params) {[self handleDeeplink:params];};
            
            return config;
        }

- (void)handleDeeplink:(SingularLinkParams*)params{
            // 从 Singular Link 获取深度链接数据
            NSString* deeplink = [params getDeepLink];
            NSString* passthrough = [params getPassthrough];
            BOOL isDeferredDeeplink = [params isDeferred];
            NSDictionary *urlParams = [params getUrlParameters];
            // 在此处添加深层链接处理代码
        }

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity
         restorationHandler:(void (^)(NSArray<id> *restorableObjects))restorationHandler {
            // 当用户在后台使用单一链接打开应用程序时启动新会话
            SingularConfig *config = [self getConfig];
            config.userActivity = userActivity;
            [Singular start:config];
            return YES;
        }
        
        // openURL

        - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
            // 当用户使用非单一链接打开应用程序时启动新会话，就像传统的应用程序方案一样。
            SingularConfig *config = [self getConfig];
            config.openUrl = url;
            [Singular start:config];
            // 在此处添加自定义代码以重定向到非单数深层链接
            // ,,,
            return YES;
        }

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//  [[Branch getInstance] application:app openURL:url options:options];
//  return YES;
//}

//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler API_AVAILABLE(ios(8.0)){
//    // Handler for Universal Links
//    [[Branch getInstance] continueUserActivity:userActivity];
//    return YES;
//}

//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
////    [[Branch getInstance] handlePushNotification:userInfo];
//    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//
//}


//- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
//    NSLog(@"FCM registration token: %@", fcmToken);
//    [[NSUserDefaults standardUserDefaults] setObject:fcmToken forKey: @"FCMtoken"];
//    // Notify about received token.
//    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:
//     @"FCMToken" object:nil userInfo:dataDict];
//    // TODO: If necessary send token to application server.
//    // TODO: 如有必要，将令牌发送到应用程序服务器。
//
//    // Note: This callback is fired at each app startup and whenever a new token is generated.
//    // 注意：每次应用程序启动以及生成新令牌时都会触发此回调。
//}

//// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
//// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
//// the FCM registration token.
////系统通常会在应用每次启动时用注册令牌调用此方法一次
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [[FIRMessaging messaging]tokenWithCompletion:^(NSString * _Nullable token, NSError * _Nullable error) {
//        if (error != nil) {
//            NSLog(@"Error getting FCM registration token: %@", error);
//          } else {
//            NSLog(@"FCM registration token: %@", token);
////            self.fcmRegTokenMessage.text = token;
//          }
//    }];
//
//   [FIRMessaging messaging].APNSToken = deviceToken;
//}


//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//       willPresentNotification:(UNNotification *)notification
//         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
//    NSDictionary *userInfo = notification.request.content.userInfo;
//    if (userInfo[kGCMMessageIDKey]) {
//        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//    }
//
//    //将此更改为您首选的显示选项
//    completionHandler(UNNotificationPresentationOptionNone);
//
//    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//}

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//didReceiveNotificationResponse:(UNNotificationResponse *)response
//         withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
//    NSDictionary *userInfo = response.notification.request.content.userInfo;
//    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//    completionHandler();
//}

@end
