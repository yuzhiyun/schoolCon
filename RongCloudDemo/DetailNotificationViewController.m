
//
//  DetailNotificationViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "DetailNotificationViewController.h"

@interface DetailNotificationViewController ()

@end

@implementation DetailNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=pubString;
    
    /**
     * 显示网页
     */
    NSString *url=@"http://mp.weixin.qq.com/s/m3y2dvyWLxHoFskyX5aWPQ";
    NSURL *nsUrl=[NSURL URLWithString:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:nsUrl];
    
    [_UIWebViewNotify loadRequest:request];
    
    
    
    
    
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

@end
