//
//  RotateImgArticleViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "RotateImgArticleViewController.h"

@interface RotateImgArticleViewController ()

@end

@implementation RotateImgArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * 显示网页
     */
   
    NSURL *nsUrl=[NSURL URLWithString:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:nsUrl];
    
    [_UIWebViewRotateImgArticle loadRequest:request];

    
    
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
