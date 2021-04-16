//
//  GamaCore.m
//  GamaGame
//
//  Created by Mgs on 2021/4/13.
//

#import "GamaCore.h"
#import "GamaTools.h"
@implementation GamaCore
+(void)didFinishLaunchApplication:(UIApplication *)app
                    launchOptions:(NSDictionary *)options
                           window:(UIWindow *)window
                  rootViewControl:(UIViewController*)vc{
    [GamaTools bindWindow:window rootViewControl:vc];
}

/// App进入活跃状态
+(void)didBeComeActive{
    NSLog(@"%s",__func__);
}

/// App 进入后台
+(void)didEnterBackground{
    
}

/// App 将退出
+(void)willTerminate{
    
}
@end
