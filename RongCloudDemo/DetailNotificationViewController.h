//
//  DetailNotificationViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNotificationViewController : UIViewController{
    
    
@public
    NSString *pubString;
@public
    NSString *articleId;
@public
    NSString *urlString;

}
@property (weak, nonatomic) IBOutlet UIWebView *UIWebViewNotify;

//@property (strong,nonatomic) NSString *mDetailString;
@end
