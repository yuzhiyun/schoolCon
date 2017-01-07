//
//  LoginViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/24.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "MainViewController.h"
#import "ChooseSchoolTableViewController.h"
#import "ForgetPwdViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
//    头像圆形
    self.UIImageViewAvatar.layer.masksToBounds = YES;
    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
    
//    隐藏返回按钮navigationController的navigationBar
//    self.navigationController.navigationBarHidden=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}


- (IBAction)forgetPwd:(id)sender {
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    nextPage->index=3;
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)active:(id)sender {
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    nextPage->index=2;
    [self.navigationController pushViewController:nextPage animated:YES];
}











@end
