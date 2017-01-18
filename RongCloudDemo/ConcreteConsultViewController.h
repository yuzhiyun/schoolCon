//
//  ConcreteConsultViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/14.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConcreteConsultViewController : UIViewController{
    
@public
    NSString *consultId;
}
@property (weak, nonatomic) IBOutlet UIWebView *mUIWebViewConsult;


@end
