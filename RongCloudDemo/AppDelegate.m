//
//  AppDelegate.m
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "AppDelegate.h"

#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>
#import "ConnectRongyunViewController.h"
#import <RongIMKit/RongIMKit.h>

#define RONGCLOUD_IM_APPKEY @"qd46yzrf47sjf" //请换成您的appkey
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //初始化全局变量
    onlineReadinngTitle=[[NSMutableArray alloc]init];
    indexOnlineReadinng=0;
     AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    myDelegate.ipString=@"http://school.sukclub.com";
//    myDelegate.ipString=@"172.27.35.7";
//    myDelegate.ipString=@"172.27.35.6";
    myDelegate.token=@"";
//    172.27.35.7
    myDelegate.appId=@"03a8f0ea6a";
    myDelegate.appSecret=@"b4a01f5a7dd4416c";
    
    myDelegate.navigationBarColor=[UIColor colorWithRed:44/255.0 green:191/255.0 blue:242/255.0 alpha:1.0];
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    /**
     * 推送处理
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    //登陆融云
    [self loginRongCloud];
    
    return YES;
}
/**
 *登录融云
 *
 */
-(void)loginRongCloud{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    NSString*token=@"J0CpaUdo1MG+j57xWHh7Ah7iozBA2NK8M4ntPTJeFk4G5N1/m+10v6kSFcRGYeYkmsxMAm3kGX4RTYsqa9iIHg==";
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        

        NSLog(@"登录成功登录成功登录成功登录成功登录成功登录成功登录成功登录成功Login successfully with userId: %@.", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
    
}

/**
 *  将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
//    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"提示"
//                              message:@"您"
//                              @"的帐号在别的设备上登录，您被迫下线！"
//                              delegate:nil
//                              cancelButtonTitle:@"知道了"
//                              otherButtonTitles:nil, nil];
//        [alert show];
//        ConnectRongyunViewController *loginVC = [[ConnectRongyunViewController alloc] init];
//        UINavigationController *_navi =
//        [[UINavigationController alloc] initWithRootViewController:loginVC];
//        self.window.rootViewController = _navi;
//    }
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
