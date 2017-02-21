//
//  LineChartViewController.m
//  SchoolCon
//
//  Created by 秦启飞 on 2017/2/20.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "LineChartViewController.h"
#import "AppDelegate.h"
@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *mUIWebView=[self.view viewWithTag:1];
    
    /**
     * 显示网页
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/api/sch/score/chart" ,myDelegate.ipString]];
    
    
    
    NSString *body = [NSString stringWithFormat: @"typeId=%@&token=%@&appId=%@&appSecret=%@", typeId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [mUIWebView loadRequest: request];
    

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
