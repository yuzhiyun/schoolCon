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
    
    /**
     *用于区分是否是我的测试那里查看结果页面
     */
    
@public
    NSString *type;
}
@property (weak, nonatomic) IBOutlet UIWebView *mUIWebView;
@end
