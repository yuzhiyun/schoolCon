

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>
#import "ConnectRongyunViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "Alert.h"
#import "Toast.h"
#import "LoginViewController.h"
// 引入JPush功能所需头文件
#import "MBProgressHUD.h"
#import "DataBaseNSUserDefaults.h"
#import "JPUSHService.h"
#import "AFNetworking.h"
#import "JsonUtil.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "WXApi.h"
#endif

#define RONGCLOUD_IM_APPKEY @"qd46yzrf47sjf" //请换成您的appkey
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
    /**
     *JPush
     *
     *
     */
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"ef6b650946ed6d8030e23568"
                          channel: @"Publish channel"
                 apsForProduction:false
            advertisingIdentifier:nil];
    
    
    
    
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
    myDelegate.loadingImg=@"loading.gif";
    myDelegate.defaultAvatar=@"icon_tx.png";
    
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
    //[self loginRongCloud];
    //注册微信
    [WXApi registerApp:@"wx0158a94b751f8f2b" withDescription:@"测试--yuzhiyun"];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
     if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [self veriftPayResult];
                //再次访问服务器，再次确认是否支付成功，如果成功，跳回主页面
                /*
                MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                nextPage.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:nextPage animated:YES];
                 
                
                */
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
       // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      //  [alert show];
        //[alert release];
    }
    
}

#pragma mark 验证支付结果
-(void)veriftPayResult {
   // MBProgressHUD *hud;
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
   // hud.labelText = @" 获取数据...";
    //[hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString;
    if([@"activity" isEqualToString: [DataBaseNSUserDefaults getData:@"orderType"]])
    
        urlString= [NSString stringWithFormat:@"%@/api/order/activity/isPayed",myDelegate.ipString];
    else if([@"vip" isEqualToString: [DataBaseNSUserDefaults getData:@"orderType"]])
        urlString= [NSString stringWithFormat:@"%@/api/order/vip/isPayed",myDelegate.ipString];
    NSLog(urlString);
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"orderId":[DataBaseNSUserDefaults getData:@"orderId"]
                                  };
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            if([[doc objectForKey:@"code"] isKindOfClass:[NSNumber class]])
                NSLog(@"code 是 NSNumber");
            
            //NSLog([doc objectForKey:@"code"]);
            //判断code 是不是0
            NSNumber *zero=[NSNumber numberWithInt:(0)];
            NSNumber *code=[doc objectForKey:@"code"];
            if([zero isEqualToNumber:code])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"恭喜您支付成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else{

                if([@"token invalid" isEqualToString:[doc objectForKey:@"msg"]]){
                    [AppDelegate reLogin:self];
                }
                else{
                    NSString *msg=[NSString stringWithFormat:@"code是%d ： %@",[doc objectForKey:@"code"],[doc objectForKey:@"msg"]];
                    [Alert showMessageAlert:msg  view:self];
                }
            }
        }
        else
            NSLog(@"*****doc空***********");
        //        NSLog([self DataTOjsonString:responseObject]);
        //          NSLog([self convertToJsonData:dic]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
       // [self.tableView footerEndRefreshing];
        //[self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        //[hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(-1009==error.code||-1016==error.code)
            
            
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}


//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//
//}


/**
 *登录融云
 */
+(void)loginRongCloud :(NSString *) token{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    //NSString *token=@"J0CpaUdo1MG+j57xWHh7Ah7iozBA2NK8M4ntPTJeFk4G5N1/m+10v6kSFcRGYeYkmsxMAm3kGX4RTYsqa9iIHg==";
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        

        NSLog(@"登录成功登录成功登录成功登录成功登录成功登录成功登录成功登录成功Login successfully with userId: %@.", userId);
    } error:^(RCConnectErrorCode status) {
        
        NSLog(@"login error status: %ld.", (long)status);
        //[Toast showToast:<#(NSString *)#> view:<#(UIView *)#>
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
}

+(void)reLogin :(UIViewController *)viewController{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @"登录状态失效，正在前往登录。。。";
    [hud show:YES];
    // 2.模拟2秒后（
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hide:YES];
        LoginViewController *nextPage= [viewController.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        nextPage.hidesBottomBarWhenPushed=YES;
        nextPage->isFromTokenInValid=YES;
        nextPage->phone=[DataBaseNSUserDefaults getData:@"phone"];
        nextPage->pwd=[DataBaseNSUserDefaults getData:@"pwd"];
        [viewController.navigationController pushViewController:nextPage animated:YES];
        
    });
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
    
    
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    //NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken 成功");
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
+(Boolean) isTeacher{
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSNumber *userType=[DataBaseNSUserDefaults getData:@"userType"];
    //是老师
    if([[NSNumber numberWithInt:(0)] isEqualToNumber:userType])
        return true;
    else
        return false;
}
@end
