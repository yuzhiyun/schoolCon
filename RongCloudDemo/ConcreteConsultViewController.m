//
//  ConcreteConsultViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/14.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ConcreteConsultViewController.h"

@interface ConcreteConsultViewController ()

@end

@implementation ConcreteConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     * 显示网页
     */
    NSString *url=@"https://mp.weixin.qq.com/s?__biz=MzI0NzcwMjk4OA==&mid=100000058&idx=1&sn=be10b875506998ae4fd4ebf037580bdb&chksm=69aab5995edd3c8f6a8bb61254373f77ad51cbd347bf808af3284a8b89095f8e7ff4bcb1e276&mpshare=1&scene=1&srcid=0109nmCA3HFqA5R6uw2Ctvbt&key=a4a4b4b1ab1c60943e36963120226d24e0e3470276f4f8431f4ce1b3255c85521b875e073536bbc545c82f709d140d380c8f40a8771900f24f3481b47cf4ce6b5c94510fd5ffd8c4b84b4b7d60a32a4e&ascene=0&uin=ODk4MzEwMTY5&devicetype=iMac+MacBookAir6%2C2+OSX+OSX+10.12.1+build(16B2555)&version=12010210&nettype=WIFI&fontScale=100&pass_ticket=gLigsYUageUfMfyUCRYEEUnvhAkH2%2BwYNaz83cLnA%2F3bXoIpzkMunbIBNAu2VYbw";
    NSURL *nsUrl=[NSURL URLWithString:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:nsUrl];
    
    [_mUIWebViewConsult loadRequest:request];
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
