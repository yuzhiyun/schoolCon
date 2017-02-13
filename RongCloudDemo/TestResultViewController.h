//
//  TestResultViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/18.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestResultViewController : UIViewController{

@public
    NSString *testId;
@public
    NSString *testName;
@public
    NSString *picUrl;

@public
    NSString *score;
}
@property (weak, nonatomic) IBOutlet UIWebView *mUIWebView;
@end
