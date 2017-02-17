//
//  DetailYuluViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "DetailYuluViewController.h"
#import "JoinViewController.h"
#import "AppDelegate.h"
@interface DetailYuluViewController ()

@end

@implementation DetailYuluViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.title=pubString;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    /**
     * 显示网页
     */
    NSURL *url = [NSURL URLWithString: urlString];
    
    
    
    NSString *body = [NSString stringWithFormat: @"id=%@&token=%@&appId=%@&appSecret=%@", activityId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [_UIWebViewActivity loadRequest: request];
    
    
    
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];

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
- (IBAction)join:(id)sender {
    
    //根据storyboard id来获取目标页面
    JoinViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"JoinViewController"];

    nextPage->activityId=activityId;
    nextPage->activityType=activityType;
    nextPage->activityName=activityName;
    nextPage->picurl=picurl;
    
    
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
}

@end
