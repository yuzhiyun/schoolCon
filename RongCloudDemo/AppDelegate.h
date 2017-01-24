//
//  AppDelegate.h
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMConnectionStatusDelegate>
{
//   全局变量  在线学习的viewpager的上部导航栏title
    NSMutableArray *onlineReadinngTitle;
//   记录在线学习的viewpager当前页面是第几页
    int *indexOnlineReadinng;
    
    NSString *ipString;
    NSString *token;
    NSString *appId;
    NSString *appSecret;
    NSString *schoolId;
    
    NSString *userName;
    NSString *phone;
    NSString *pwd;
    
    UIColor *navigationBarColor;
    
}
@property (strong, nonatomic) UIWindow *window;

/** 设置全局变量的属性. */
@property (nonatomic, strong)NSMutableArray *onlineReadinngTitle;
@property (nonatomic)int *indexOnlineReadinng;
@property (nonatomic,strong)NSString *ipString;
@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *appId;
@property (nonatomic,strong)NSString *appSecret;
@property (nonatomic,strong)NSString *schoolId;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *pwd;
@property (nonatomic,strong)UIColor *navigationBarColor;

@end

