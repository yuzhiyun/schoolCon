//
//  TestIntroductionViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/13.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "TestIntroductionViewController.h"
#import "TestViewController.h"
@interface TestIntroductionViewController ()

@end

@implementation TestIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    /**
     * 显示网页
     */
    NSString *url=@"http://mp.weixin.qq.com/s/m3y2dvyWLxHoFskyX5aWPQ";
    NSURL *nsUrl=[NSURL URLWithString:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:nsUrl];
    
    [_UIWebViewtest loadRequest:request];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTest:(id)sender {
    
    
    TestViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
//    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}


@end
