#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "CZDeviceUtils.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    [[CZDeviceUtils sharedManager] getDeviceInfo];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
