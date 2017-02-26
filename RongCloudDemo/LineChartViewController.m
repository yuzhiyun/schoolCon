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
    
    self.title=@"建议横屏显示，效果更佳";
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    
//    [self setNewOrientation:YES];//调用转屏代码
//    [self forceO
    UIWebView *mUIWebView=[self.view viewWithTag:1];
    
    /**
     * 显示网页
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/api/sch/score/chart" ,myDelegate.ipString]];
    
    
    NSString *body;
    
    if(![AppDelegate isTeacher]){
        
        NSLog(typeId);
        NSLog(myDelegate.token);
        NSLog(myDelegate.appId);
        NSLog(myDelegate.appSecret);
        
        body = [NSString stringWithFormat: @"typeId=%@&token=%@&appId=%@&appSecret=%@", typeId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    }
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
//- (void)setNewOrientation:(BOOL)fullscreen
//
//{
//    
//    if (fullscreen) {
//        
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//        
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//        
//        
//        
//        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//        
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//        
//    }else{
//        
//        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//        
//        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
//        
//        
//        
//        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//        
//        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//        
//    }
//    
//}
//
//
//
//
//
////3.重写导航栏返回箭头按钮,拿到返回按钮点击事件
//
//- (void)back
//
//{
//    
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
//    
//    [self setNewOrientation:NO];
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}
//
//
@end
