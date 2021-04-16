//
//  GamaCore.h
//  GamaGame
//
//  Created by Mgs on 2021/4/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GamaCore : NSObject

/// App生命周期入口函数
/// @param app application
/// @param options launchOptions
/// @param window App 的keyWindow
/// @param vc 根控制器
+(void)didFinishLaunchApplication:(UIApplication *)app
                    launchOptions:(NSDictionary *)options
                           window:(UIWindow *)window
                  rootViewControl:(UIViewController*)vc;

/// App进入活跃状态
+(void)didBeComeActive;

/// App 进入后台
+(void)didEnterBackground;

/// App 将退出
+(void)willTerminate;


@end

NS_ASSUME_NONNULL_END
