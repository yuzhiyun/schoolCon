//
//  EntranceViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/26.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "EntranceViewController.h"
#import "LoginViewController.h"
#import "ChooseSchoolTableViewController.h"
@interface EntranceViewController ()

@end

@implementation EntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    隐藏返回按钮navigationController的navigationBar
        self.navigationController.navigationBarHidden=YES;
    [self.UIButtonLogin.layer setMasksToBounds:YES];
    [self.UIButtonActive.layer setMasksToBounds:YES];
    
    [self.UIButtonLogin.layer setCornerRadius:4.0]; //设置圆角，数学不好，数值越小越不明显，自己找一个合适的值
    [self.UIButtonActive.layer setCornerRadius:4.0];
    
    [self.UIButtonLogin.layer setBorderWidth:0.5];//设置边框的宽度
    
    [self.UIButtonLogin.layer setBorderColor:[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0] CGColor]];//设置颜色
    //    头像圆形
//    self.UIImageViewAvatar.layer.masksToBounds = YES;
//    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
    
    // Do any additional setup after loading the view.
    
    //    隐藏返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    //根据storyboard id来获取目标页面
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    //    传值
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
//    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
}

- (IBAction)active:(id)sender {
    
    
}

@end
