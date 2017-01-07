//
//  ActiveViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ActiveViewController.h"
#import "MainViewController.h"
#import "SetPwdAfterActiveViewController.h"
@interface ActiveViewController ()

@end

@implementation ActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"激活";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)active:(id)sender {
    SetPwdAfterActiveViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"SetPwdAfterActiveViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}

@end
