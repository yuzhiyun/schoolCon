//
//  ConcreteConsultViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/14.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ConcreteConsultViewController.h"
#import "AppDelegate.h"
@interface ConcreteConsultViewController ()

@end

@implementation ConcreteConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *显示网页
     */
    
    
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    

    NSString *urlString=[NSString stringWithFormat:@"%@/api/psy/consultant/getObject",myDelegate.ipString];
    
    NSURL *url = [NSURL URLWithString: urlString];
    NSString *body = [NSString stringWithFormat: @"id=%@&token=%@&appId=%@&appSecret=%@", consultId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [_mUIWebViewConsult loadRequest: request];
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

@end
