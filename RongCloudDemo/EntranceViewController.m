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
    //    头像圆形
    self.UIImageViewAvatar.layer.masksToBounds = YES;
    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
    
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
