//
//  GamaTools.m
//  GamaGame
//
//  Created by Mgs on 2021/4/13.
//

#import "GamaTools.h"
#import "Reachability.h"
#import "GamaRateView.h"
static UIWindow * mWindow = nil;
static UIViewController * mRootViewController = nil;
@implementation GamaTools
//绑定App 的window 和根控制器
+(void)bindWindow:(UIWindow *)window rootViewControl:(UIViewController *)vc{
    mWindow = window;
    mRootViewController = vc;
}
/// 获取window
+(UIWindow *)getWindow{
    if (mWindow) {
        return mWindow;
    }
    return nil;
}

/// 获取控制器
+(UIViewController *)getViewControl{
    if (mRootViewController) {
        return mRootViewController;
    }
    return nil;
}

/// 获取版本号
+(NSString*)getVersion{
    NSDictionary *infos = [[NSBundle mainBundle] infoDictionary];
    return [infos objectForKey:@"CFBundleShortVersionString"];
}

/// iPhone X 及其以后的手机
+(BOOL)isIPhoneXSeries{
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [GamaTools getWindow];
        if (window.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}

/// 手机系统语言是否是简体中文
+(BOOL)isSimpleChinese{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];

    NSString * preferredLang = [allLanguages objectAtIndex:0];
    
    if ([preferredLang hasPrefix:@"zh-Hans-CN"]) {
        return true;
    }
    return false;
}

/// 获取手机系统语言
+(GamaLanguageType)getDeviceLanguage{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    if ([preferredLang hasPrefix:@"zh-Hans-CN"]) {
        return Gama_SimpleChinese;
    }
    if ([preferredLang hasPrefix:@"zh-Hant"]) {
        return Gama_TraditionalChinese;
    }
    if ([preferredLang hasPrefix:@"en-"]) {
        return Gama_English;
    }
    if ([preferredLang hasPrefix:@"ja-"]) {
        return Gama_Japanese;
    }
    if ([preferredLang hasPrefix:@"ko-"]) {
        return Gama_Korean;
    }
    if ([preferredLang hasPrefix:@"fr-"]) {
        return Gama_French;
    }
    if ([preferredLang hasPrefix:@"it-"]) {
        return Gama_Italian;
    }
    if ([preferredLang hasPrefix:@"de-"]) {
        return Gama_German;
    }
    if ([preferredLang hasPrefix:@"ru-"]) {
        return Gama_Russian;
    }
    if ([preferredLang hasPrefix:@"es-"]) {
        return Gama_Spanish;
    }
    return Gama_English;
}

/// 检查网络是否可用
+(int)getNetworkStatus{
    Reachability *r = [Reachability reachabilityWithHostName:@"https://www.baidu.com/"];
    if ([r currentReachabilityStatus]== NotReachable) {
        return 0;//没有连接网络
    }
    if ([r currentReachabilityStatus]== NotReachable) {
        return 1;//WWAN
    }
    if ([r currentReachabilityStatus]== NotReachable) {
        return 2;//WIFI
    }
    return -1;//未知网络
}

/// 振动
+(void)vibrate:(int)time{
    if (time<30) {
        if (@available(iOS 10.0, *)) {
            UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleHeavy];
            [impactLight impactOccurred];
        } else {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }else{
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

/// 是否是下载首日
#define FIRSTDAYKEY @"DFJKASHDIU7782009bnbnd"
+(BOOL)isDownloadFirstDay{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *fd = [def objectForKey:FIRSTDAYKEY];
    if (!fd||[fd isEqualToString:@""]) {
        [def setObject:str forKey:FIRSTDAYKEY];
        return true;
    }
    if ([fd isEqualToString:str]) {
        return true;
    }
    return false;
}

/// 获取设置唯一标识
+(NSString *)getDeviceUniqueId{
    return [DeviceId getUUIDByKeyChain];
}

/// 打开用户评价
+(void)openRate{
    NSLog(@"%s",__func__);
    [GamaRateView openRate:mRootViewController.view];
}
@end
