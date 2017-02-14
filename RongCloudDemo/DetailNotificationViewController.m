
//
//  DetailNotificationViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "DetailNotificationViewController.h"
#import "AppDelegate.h"

@interface DetailNotificationViewController ()

@end

@implementation DetailNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=pubString;
    
    
   // /api/sys/notice/getObject
    
    
    /**
     * 显示网页
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString: urlString];
    
    
    
    NSString *body = [NSString stringWithFormat: @"id=%@&token=%@&appId=%@&appSecret=%@", articleId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [_UIWebViewNotify loadRequest: request];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNotificationViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationViewController"];
//    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}

@end
