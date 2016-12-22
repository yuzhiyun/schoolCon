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
    
    
    
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    /**
     * 推送处理1
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
    
//    // 初始化 ViewController。
//    ViewController *viewController = [[ViewController alloc]initWithNibName:nil bundle:nil];
//    
//    // 初始化 UINavigationController。
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
//    
//    // 设置背景颜色为黑色。
//    [nav.navigationBar setBackgroundColor:[UIColor blackColor]];
//    
//    // 初始化 rootViewController。
//    self.window.rootViewController = nav;
//    
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//    UIFont *font = [UIFont systemFontOfSize:19.f];
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName : font,
//                                     NSForegroundColorAttributeName : [UIColor whiteColor]
//                                     };
//    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance]
//     setBarTintColor:[UIColor colorWithRed:(1 / 255.0f) green:(149 / 255.0f) blue:(255 / 255.0f) alpha:1]];
//    
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
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"登录成功登录成功登录成功登录成功登录成功登录成功登录成功登录成功Login successfully with userId: %@.", userId);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
//            
//            /*
//             *
//             *  之前我在官方的demo基础上添加tab bar controller，但是总是打不开消息列表界面，在connect的回调函数中出现login error status:-1000错误
//             *  其实这不算错误，谨记，因为我一个劲点击按钮，多次调用了connect函数，所以就报这个错误，
//             *  最终找到问题所在了，第一次其实连接成功啦，只是我把navigationController删除了，但是呢，程序中页面跳转代码都使用了navigationController，
//             *  这就导致这些页面跳转代码下一行代码无法执行，所以只要在main.storyboard中给起始页面添加一个*UINavigationController即可，一切搞定，
//             */
//            chatListViewController.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:chatListViewController animated:YES];
//        });
        
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
