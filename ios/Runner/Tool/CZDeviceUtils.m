//
//  CZDeviceUtils.m
//  Runner
//
//  Created by 陈浩 on 2023/6/15.
//

#import "CZDeviceUtils.h"
#import <Flutter/Flutter.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

static NSString* kDeviceUdidKey = @"com.rupee.rain.udid.device";
static NSString *kDeviceUuid = @"deviceUuid";
// 单例对象
static CZDeviceUtils *_CZDeviceUtils = nil;

@interface CZDeviceUtils()
/** 渠道 */
@property(nonatomic,strong) FlutterMethodChannel *deviceChannel;
@end

@implementation CZDeviceUtils

#pragma mark - 单例方法
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CZDeviceUtils = [[self alloc] init];
    });
    return _CZDeviceUtils;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CZDeviceUtils = [super allocWithZone:zone];
    });
    return _CZDeviceUtils;
}

- (id)copyWithZone:(NSZone *)zone {
    return _CZDeviceUtils;
}

- (void)getDeviceInfo {
    [CZDeviceUtils requestIDFA];
    FlutterViewController* controller = (FlutterViewController*)[[[UIApplication sharedApplication] windows] firstObject].rootViewController;
    // 2.获取MethodChannel(方法通道)
    self.deviceChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"com.rupee.rain/device"
                                            binaryMessenger:controller.binaryMessenger];
    __weak typeof(self) weakSelf = self;
    [self.deviceChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      if ([@"getDeviceInfo" isEqualToString:call.method]) {
          result(@{@"AID":[CZDeviceUtils getDeviceUuid],@"GAID":[CZDeviceUtils getIDFA]});
//          result([FlutterError errorWithCode:@"UNAVAILABLE"
//                                     message:@"device info unavailable"
//                                     details:nil]);
      } else if ([@"jumpContacts" isEqualToString:call.method]) {
          [weakSelf jumpContacts];
      } else {
        result(FlutterMethodNotImplemented);
      }
    }];
}

- (void)jumpContacts {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"App-prefs:CONTACTS"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-prefs:CONTACTS"] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
            
        }];
    }
}

+ (void)saveDeviceUuid:(NSString *)uuid {
    if (!uuid.length) {
        uuid = @"";
    }
    NSUserDefaults *user_default = [NSUserDefaults standardUserDefaults];
    [user_default setObject:uuid forKey:kDeviceUuid];
    [user_default synchronize];
}

+ (NSString *)getDeviceUuid {
    NSUserDefaults *user_default = [NSUserDefaults standardUserDefaults];
    NSString *device_uuid = [user_default objectForKey:kDeviceUuid];
    if (device_uuid != nil && device_uuid.length) {
        return device_uuid;
    }
    device_uuid = [self deviceID] ? : @"";
    [self saveDeviceUuid:device_uuid];
    return device_uuid;
}

+ (NSString *)deviceID
{
    return [self getDeviceIDInKeychain];
}

+(NSString *)getDeviceIDInKeychain {
    NSString *getUDIDInKeychain = (NSString *)[self load:kDeviceUdidKey];
    if (!getUDIDInKeychain ||
        [getUDIDInKeychain isEqualToString:@""] ||
        [getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        [self save:kDeviceUdidKey data:result];
        getUDIDInKeychain = (NSString *)[self load:kDeviceUdidKey];
    }
    
    return getUDIDInKeychain;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData) {
        CFRelease(keyData);
    }
    
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

#pragma mark - 获取idfa
+ (void)requestIDFA {
    if (@available(iOS 14, *)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                // 无需对授权状态进行处理
            }];
        });
        
    } else {
        // Fallback on earlier versions
    }
}

+ (NSString*)getIDFA {
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString] ? : @"";
    return idfa;
}

@end
