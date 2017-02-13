//
//  TestIntroductionViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/13.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "TestIntroductionViewController.h"
#import "TestViewController.h"
#import "AppDelegate.h"
@interface TestIntroductionViewController ()

@end

@implementation TestIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    /**
     *显示网页
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString=[NSString stringWithFormat:@"%@/api/psy/test/getObject",myDelegate.ipString];
    NSURL *url = [NSURL URLWithString: urlString];
    NSString *body = [NSString stringWithFormat: @"id=%@&token=%@&appId=%@&appSecret=%@", testId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [_UIWebViewtest loadRequest: request];
 
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTest:(id)sender {
    
    
    TestViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
    //nextPage->testId=testId;
    nextPage->testId=testId;
    nextPage->testName=testName;
    nextPage->picUrl=picUrl;
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}


@end
