//
//  DetailYuluViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailYuluViewController : UIViewController{
    
    
@public
    NSString *activityId;
@public
    NSString *title;
    
@public
    NSString *pubString;
@public
    NSString *urlString;
}
@property (weak, nonatomic) IBOutlet UIWebView *UIWebViewActivity;


@end
