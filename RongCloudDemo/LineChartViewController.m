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
    
//    [self forceO
    UIWebView *mUIWebView=[self.view viewWithTag:1];
    
    /**
     * 显示网页
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/api/sch/score/chart" ,myDelegate.ipString]];
    
    
    NSString *body;
    
    if(![AppDelegate isTeacher])
        body = [NSString stringWithFormat: @"typeId=%@&token=%@&appId=%@&appSecret=%@", typeId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    else{
        
        NSLog(@"%教师选择studentId@",studentId);
        NSLog(@"%教师选择typeId@",typeId);
        body = [NSString stringWithFormat: @"studentId=%@&typeId=%@&token=%@&appId=%@&appSecret=%@", studentId,typeId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [mUIWebView loadRequest: request];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate
{
    return YES;
    
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //横屏显示
    return UIInterfaceOrientationMaskLandscape;
}


@end
