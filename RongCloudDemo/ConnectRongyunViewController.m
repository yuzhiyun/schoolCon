//
//  ViewController.m
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "ConnectRongyunViewController.h"
#import "ChatListViewController.h"
#import <RongIMKit/RCConversationViewController.h>
@interface ConnectRongyunViewController ()

@end

@implementation ConnectRongyunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 初始化 UINavigationController。
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self];
//
//                    // 设置背景颜色为黑色。
//                    [nav.navigationBar setBackgroundColor:[UIColor blackColor]];
    CGRect viewSize=self.view.bounds;
    UIButton*loginButton=[[UIButton alloc]initWithFrame:CGRectMake(viewSize.size.width/2-50, viewSize.size.height/2, 100, 50)];
    
    [loginButton setTitle:@"登录融云" forState:UIControlStateNormal];
    loginButton.backgroundColor=[UIColor blueColor];
    [loginButton addTarget:self action:@selector(loginRongCloud) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    
    

}

/**
 *登录融云
 *
 */
-(void)loginRongCloud
{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    NSString*token=@"J0CpaUdo1MG+j57xWHh7Ah7iozBA2NK8M4ntPTJeFk4G5N1/m+10v6kSFcRGYeYkmsxMAm3kGX4RTYsqa9iIHg==";

    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"登录成功登录成功登录成功登录成功登录成功登录成功登录成功登录成功Login successfully with userId: %@.", userId);
        dispatch_async(dispatch_get_main_queue(), ^{
        ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
            
/*
 *
 *  之前我在官方的demo基础上添加tab bar controller，但是总是打不开消息列表界面，在connect的回调函数中出现login error status:-1000错误
 *  其实这不算错误，谨记，因为我一个劲点击按钮，多次调用了connect函数，所以就报这个错误，
 *  最终找到问题所在了，第一次其实连接成功啦，只是我把navigationController删除了，但是呢，程序中页面跳转代码都使用了navigationController，
 *  这就导致这些页面跳转代码下一行代码无法执行，所以只要在main.storyboard中给起始页面添加一个*UINavigationController即可，一切搞定，
 */
            chatListViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:chatListViewController animated:YES];
        });

    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];

}
/*
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
    }else if([@"2" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"2";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
