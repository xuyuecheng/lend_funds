//
//  CZDeviceInfoUtils.m
//  Runner
//
//  Created by 陈浩 on 2023/6/15.
//

#import "CZDeviceInfoUtils.h"
#import <Flutter/Flutter.h>
#import "CZDeviceUtils.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
 #import <CoreTelephony/CTCarrier.h>
#import "Reachability.h"
#include <sys/sysctl.h>
#include <mach/machine.h>
#include <mach/mach_host.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>
#import <sys/stat.h>
#import <dlfcn.h>
#import "objc/runtime.h"
#import <SystemConfiguration/CaptiveNetwork.h>
// 单例对象
static CZDeviceInfoUtils *_CZDeviceInfoUtils = nil;

@interface CZDeviceInfoUtils()
@end

@implementation CZDeviceInfoUtils

#pragma mark - 单例方法
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CZDeviceInfoUtils = [[self alloc] init];
    });
    return _CZDeviceInfoUtils;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CZDeviceInfoUtils = [super allocWithZone:zone];
    });
    return _CZDeviceInfoUtils;
}

- (id)copyWithZone:(NSZone *)zone {
    return _CZDeviceInfoUtils;
}

+ (NSDictionary*) getDeviceInfo{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *generalData = self.getGeneralData;
    NSDictionary *hardware = self.getHardware;
    NSDictionary *publicIp = self.getPublicIp;
    NSDictionary *simCard = self.getSimCard;
    NSDictionary *otherData = self.getOtherData;
    NSDictionary *location = self.getLocation;
    NSDictionary *storage = self.getStorage;
    NSDictionary *devFile = self.getDevFile;
    NSDictionary *batteryStatus = self.getBatteryStatus;
    NSDictionary *currWifi = self.getCurrWifi;
    NSArray *configWifi = @[];
    [dict setValue:generalData forKey:@"generalDataCbw4j2"];
    [dict setValue:hardware forKey:@"hardwareshZccz"];
    [dict setValue:publicIp forKey:@"publicIpyeOakN"];
    [dict setValue:simCard forKey:@"simCardlqMEZf"];
    [dict setValue:otherData forKey:@"otherDatau7YSHK"];
    [dict setValue:location forKey:@"locationfwQn24"];
    [dict setValue:storage forKey:@"storageuTosYG"];
    [dict setValue:devFile forKey:@"devFilej9tCrF"];
    [dict setValue:batteryStatus forKey:@"batteryStatuslDRugQ"];
    [dict setValue:currWifi forKey:@"currWifiLloy16"];
    [dict setValue:configWifi forKey:@"configWifiucSQNF"];
    return @{@"modelU8mV9A":dict};
}

+(NSDictionary *)getGeneralData{
    return  @{
        @"andIda8Da85":[CZDeviceUtils getIDFV],
        @"phoneTypeT8t1XN":@"",
        @"mncXihCRh":self.getMnc,
        @"gaidkgXLB7":[CZDeviceUtils getIDFA],
        @"dnsiqpJ6o":@"",
        @"languageXDduTh":self.getDeviceLanguage,
        @"mccEZIYdH":self.getMcc,
        @"networkOperatorz7WYI7":@"",
        @"networkOperatorName":self.getNetworkOperatorName,
        @"localeIso3LanguageReFQaF":self.getLocaleIso3Language,
        @"localeDisplayLanguageSklNRK":@"",
        @"imeiIYTirF":@"",
        @"phoneNumberl6YZEE":@"",
        @"networkTypegkqh5l":self.getNetName,
        @"timeZoneIdcK23TV":self.getTimeZoneId,
        @"localeIso3CountryAsnKI4":@"",
    };
}

+(NSDictionary *)getHardware{
    return  @{
        @"deviceNameVlHKdf":[[UIDevice currentDevice] name],
        @"brandcW0g8g":@"Apple",
        @"productI8T9N3":@"",
        @"modelU8mV9A":[[UIDevice currentDevice] model],
        @"releases1OMDC":[[UIDevice currentDevice] systemVersion],
        @"cpuTypeqxjuJC":self.getCPUType,
        @"sdkVersionAZVEkJ":@"",
        @"serialNumberMYvlMN":@"",
        @"physicalSizebroJOD":@"",
        @"manufacturerSu3DFB":@"",
        @"displaymh1Iu1":@"",
        @"fingerprintcgzBn3":@"",
        @"abistHGENT":@[],
        @"boardQIvTBC":@"",
        @"buildIdfIzSX8":@"",
        @"hostYXZkpJ":@"",
        @"typeIVyt6h":@"",
        @"buildUserFdbNYb":@"",
        @"cpuAbibgZnBU":@"",
        @"cpuAbi2ONqYXh":@"",
        @"bootloaderdS2w1y":@"",
        @"hardwareshZccz":@"",
        @"baseOSZz0ead":@"",
        @"radioVersionokW2pY":@"",
        @"sdCardPathrlvRKQ":@"",
        @"internalTotalSizeMYH8gU":self.getTotalMemory,
        @"internalAvailableSizemBk9wi":self.getFreeMemory,
        @"externalTotalSizeIu2yqm":self.getTotalDiskSpace,
        @"externalAvailableSizeqRHB1m":self.getFreeDiskSpace,
        @"sdCardInfoSfMU1D":@{},
    };
}

+(NSDictionary *)getPublicIp{
    return  @{
        @"intranetIpFF12Jy":self.getDeviceIPAddresses,
    };
}

+(NSDictionary *)getSimCard{
    return  @{
        @"mobileDataEnabledP4qFJi": self.simCardNumInPhone>0 ? @(YES):@(NO),
        @"mobileDataBgDTm0":@(YES),
        @"serialNumberMYvlMN":@"",
        @"simCardReadyDIZg4E":@(YES),
        @"countryIsoUf8REy":self.getLocaleIso3Language,
        @"dataNetworkTypefWyovG":@"",
        @"operatorNamepMId7j":self.getNetworkOperatorName,
        @"operatorFTVNcV":@"",
    };
}

+(NSDictionary *)getOtherData{
    return @{
        @"hasRootOQVsGS":@"",
        @"lastBootTimeKL3WDl":@"",
        @"keyboardPdFl3Y":@"",
        @"simulatorDlnIj1":@(NO),
        @"adbEnabledexy7ID":@(NO),
        @"dbmlGYZDM":self.getSignalLevel,
        @"imageNumatB9Ni":@"",
        @"screenWidthfQFwXO":@([UIScreen mainScreen].bounds.size.width),
        @"screenHeightT21iar":@([UIScreen mainScreen].bounds.size.height),
        @"screenDensityZTvcGH":@([UIScreen mainScreen].scale),
        @"screenDensityDpivhAYoX":@"",
        @"cpuNumberce4wrg":self.getCPUCount,
        @"appFreeMemoryJhIwEV":@"",
        @"appAvailableMemoryCF50wY":@"",
        @"appMaxMemorylXBi91":@"",
        @"maxBatteryITuC8t":@"",
        @"levelBatteryuLBq55":@"",
        @"totalBootTimeWakeaV7OGl":self.getDeviceModel,
        @"totalBootTimeHnoiOg":@"",
    };
}

+(NSDictionary *)getLocation{
    return @{
        @"gpsnU23GV":@{
            @"latitudeAvnzut":@"",
            @"longitudesIDO4W":@"",
        },
    };
}

+(NSDictionary *)getStorage{
    return @{
        @"ramTotalSizeOnbeXg":self.getTotalMemory,
        @"ramUsableSizeprn6kk":self.getFreeMemory,
        @"memoryCardSizelFXUtg":@"",
        @"memoryCardSizeUseQvW766":@"",
        @"mainStorageQdF0BK":@"",
        @"externalStorageR0VtD0":@"",
        @"internalStorageUsableSgXO96":self.getFreeDiskSpace,
        @"internalStorageTotalbkOcGj":self.getFreeDiskSpace,
    };
}

+(NSDictionary *)getDevFile{
    return @{
        @"audioExternalIJSGjp":@"",
        @"audioInternalgSd2ce":@"",
        @"downloadFilescQDL7l":@"",
        @"imagesExternalMI79gp":@"",
        @"imagesInternalPcUu78":@"",
        @"videoExternalprT0Lx":@"",
        @"videoInternalwEHDw0":@"",
    };
}

+(NSDictionary *)getBatteryStatus{
    return @{
        @"batteryPctgI42Et":@"",
        @"isUsbChargeW1MXzD":@"",
        @"isAcChargevFy5ZO":@"",
        @"isChargingX9iwLO":@"",
    };
}

+(NSDictionary *)getCurrWifi{
    return @{
        @"nameyJEzwD":@"",
        @"bssidTwL8VA":@"",
        @"ssidnVwsGl":@"",
        @"macB9zkMg":self.getMacAddress,
        @"ipawa25v":self.getDeviceIPAddresses,
    };
}

#pragma mark - generalData
// 获取当前语言
+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}


//+ (void)networkInfo{
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [info subscriberCellularProvider];
//    NSString *mcc = [carrier mobileCountryCode]; // 国家码 如：460
//    NSString *mnc = [carrier mobileNetworkCode]; // 网络码 如：01
//    NSString *name = [carrier carrierName]; // 运营商名称，中国联通
//    NSString *isoCountryCode = [carrier isoCountryCode]; // cn
//    BOOL allowsVOIP = [carrier allowsVOIP];// YES
//    NSString *radioAccessTechnology = info.currentRadioAccessTechnology; // 无线连接技术，如CTRadioAccessTechnologyLTE
//}


//获取mnc
+ (NSString *)getMnc{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mnc = [carrier mobileNetworkCode] ? : @""; // 网络码 如：01
    return mnc;
}

//获取mcc
+ (NSString *)getMcc{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode] ? : @""; // 国家码 如：460
    return  mcc;
}

//获取networkOperator
+ (NSString *)getNetworkOperatorName{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *name = [carrier carrierName] ? : @""; // 运营商名称，中国联通
    return name;
}

//获取localeIso3Language
+ (NSString *)getLocaleIso3Language{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *isoCountryCode = [carrier isoCountryCode] ? : @""; // cn
    return isoCountryCode;
}

//获取networkType
+ (NSString *)getNetName
{
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"WIFI";
    switch (internetStatus)
    {
        case ReachableViaWiFi:
        {
            net = @"WIFI";
            break;
        }
        case ReachableViaWWAN:
        {
//            net = @"蜂窝数据";
            net = [self getNetType];   //判断具体类型
            break;
        }
        case NotReachable:
            net = @"";
            
        default:
            break;
    }
    return net;
}
 
+ (NSString *)getNetType
{
    NSString *netName = @"";
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSDictionary *radioAccessData  = info.serviceCurrentRadioAccessTechnology;
    NSString *currentStatus = [radioAccessData objectForKey:[radioAccessData allKeys].firstObject];
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS] || [currentStatus isEqualToString:CTRadioAccessTechnologyEdge]){
        //GPRS网络
        netName = @"2G";
    }
    else if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
             [currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]
             )
    {
        netName = @"3G";
    }
    else if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE])
    {
        netName = @"4G";
    }
    else if (@available(iOS 14.1, *)) {
        if ([currentStatus isEqualToString:CTRadioAccessTechnologyNRNSA] || [currentStatus isEqualToString:CTRadioAccessTechnologyNR])
        {
            netName = @"5G";
        }
    }
    [NSNotificationCenter.defaultCenter addObserverForName:CTServiceRadioAccessTechnologyDidChangeNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification *note)
    {
        NSLog(@"New Radio Access Technology: %@", info.serviceCurrentRadioAccessTechnology);
    }];
    
    return  netName;
}

+ (NSString *)getTimeZoneId{
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSString *strZoneName = [zone name];
    return  strZoneName;
}

#pragma mark - hardware
//获取cupType
+ (NSString *)getCPUType{
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
    NSString *type = @"";
    switch (hostInfo.cpu_type) {
        case CPU_TYPE_ARM:
//            NSLog(@"CPU_TYPE_ARM");
            type = @"ARM";
            break;
            
        case CPU_TYPE_ARM64:
//            NSLog(@"CPU_TYPE_ARM64");
            type = @"ARM64";
            break;
            
        case CPU_TYPE_X86:
//            NSLog(@"CPU_TYPE_X86");
            type = @"X86";
            break;
            
        case CPU_TYPE_X86_64:
//            NSLog(@"CPU_TYPE_X86_64");
            type = @"X86_64";
            break;
            
        default:
            break;
    }
    return type;
}

// 获取磁盘总空间
+ (NSString *)getTotalDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return @"-1";
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return [NSString stringWithFormat:@"%lld", space];
}

// 获取未使用的磁盘空间
+ (NSString *)getFreeDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return @"-1";
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return [NSString stringWithFormat:@"%lld", space];
}

// 获取系统总内存空间
+ (NSString *)getTotalMemory {
    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];
    if (totalMemory < -1) totalMemory = -1;
    return [NSString stringWithFormat:@"%lld", totalMemory];
}

// 获取空闲的内存空间
+ (NSString *)getFreeMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return @"-1";
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return @"-1";
    return [NSString stringWithFormat:@"%lu", vm_stat.free_count * page_size];
}

#pragma mark - publicIp
// 获取IP地址
+ (NSString *) getDeviceIPAddresses {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

#pragma mark - simCard
///方法二：获取手机中sim卡数量（推荐）
+ (int)simCardNumInPhone {
     CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
     if (@available(iOS 12.0, *)) {
          NSDictionary *ctDict = networkInfo.serviceSubscriberCellularProviders;
          if ([ctDict allKeys].count > 1) {
               NSArray *keys = [ctDict allKeys];
               CTCarrier *carrier1 = [ctDict objectForKey:[keys firstObject]];
               CTCarrier *carrier2 = [ctDict objectForKey:[keys lastObject]];
               if (carrier1.mobileCountryCode.length && carrier2.mobileCountryCode.length) {
                    return 2;
               }else if (!carrier1.mobileCountryCode.length && !carrier2.mobileCountryCode.length) {
                    return 0;
               }else {
                    return 1;
               }
          }else if ([ctDict allKeys].count == 1) {
               NSArray *keys = [ctDict allKeys];
               CTCarrier *carrier1 = [ctDict objectForKey:[keys firstObject]];
               if (carrier1.mobileCountryCode.length) {
                    return 1;
               }else {
                    return 0;
               }
          }else {
               return 0;
          }
     }else {
          CTCarrier *carrier = [networkInfo subscriberCellularProvider];
          NSString *carrier_name = carrier.mobileCountryCode;
          if (carrier_name.length) {
               return 1;
          }else {
               return 0;
          }
     }
}

#pragma mark - otherData
+ (NSString *) getSignalLevel
{
    void *libHandle = dlopen("/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony",RTLD_LAZY);//获取库句柄
    int (*CTGetSignalStrength)(void); //定义一个与将要获取的函数匹配的函数指针
    CTGetSignalStrength = (int(*)(void))dlsym(libHandle,"CTGetSignalStrength"); //获取指定名称的函数
    
    if(CTGetSignalStrength == NULL)
        return @"-1";
    else{
        int level = CTGetSignalStrength();
        dlclose(libHandle); //切记关闭库
        return [NSString stringWithFormat:@"%d",level];
    }
}

// 获取CPU总数目
+ (NSString *) getCPUCount {
    return [NSString stringWithFormat:@"%lu",(unsigned long)[NSProcessInfo processInfo].activeProcessorCount];
}

// 获取设备上次重启的时间
+ (NSString *)getDeviceModel {
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    NSDate *lastRestartDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
    NSTimeInterval timeInterval = [lastRestartDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", timeInterval];
}

#pragma mark - location

#pragma mark - batteryStatus


#pragma mark - currWifi
// 获取mac 地址
+ (NSString *) getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

+ (NSString *)getWifiSSID {
    NSString *ssid = nil;
    CFArrayRef arrRef = CNCopySupportedInterfaces;
    NSArray *ifs = ( __bridge id)arrRef;
    for(NSString *ifnam in ifs) {
        CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo(( __bridge CFStringRef)ifnam);
        NSDictionary *info = ( __bridge id)dicRef;
        if(info[@ "BSSID"]) {
            ssid = info[@ "SSID"];
        }
        if(dicRef !=nil) {
            CFRelease(dicRef);
        }
    }
    if(arrRef != nil) {
        CFRelease(arrRef);
    }
    return ssid;
}

+ (NSString *)getWifiBSSID {
    NSString *bssid = @ "";
    CFArrayRef arrRef = CNCopySupportedInterfaces;
    NSArray *ifs = ( __bridge id)arrRef;
    for(NSString *ifnam in ifs) {
        CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo(( __bridge CFStringRef)ifnam);
        NSDictionary *info = ( __bridge id)dicRef;
        if(info[@ "BSSID"]) {
            bssid = info[@ "BSSID"];
        }
        if(dicRef != nil) {
            CFRelease(dicRef);
        }
    }
    if(arrRef != nil) {
        CFRelease(arrRef);
    }
    return bssid;
}

@end
