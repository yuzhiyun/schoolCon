//
//  TestIntroductionViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/13.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestIntroductionViewController : UIViewController{

@public
    NSString *testId;
@public
    NSString *testName;
@public
    NSString *picUrl;
@public
    NSNumber *money;
    

}
@property (weak, nonatomic) IBOutlet UIWebView *UIWebViewtest;
@property (weak, nonatomic) IBOutlet UIButton *mUIButtonPay;
-(void)afterPaySuccess;
@end
