//
//  DeviceId.h
//  Test
//
//  Created by Mgs on 2020/11/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DeviceId : NSObject
+ (NSString *)getUUIDByKeyChain;
+ (void)save:(NSString*)service data:(id)data;
+ (id)load:(NSString*)service;
+ (void)deleteKeyData:(NSString*)service;

@end

NS_ASSUME_NONNULL_END
