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
    NSString  *activityId;
@public
    NSString  *activityType;
@public
    NSString  *activityName;
@public
    NSString *picurl;

    
    
@public
    NSString *pubString;
@public
    NSString *urlString;
    
@public
    NSString  *title;
@public
    NSString  *host;
@public
    NSString  *date;
@public
    NSString  *place;
@public
    NSString  *price;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *UIWebViewActivity;
@property (weak, nonatomic) IBOutlet UIButton *mUIButtonJoinIn;


@end
