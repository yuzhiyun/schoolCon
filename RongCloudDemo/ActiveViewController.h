//
//  ActiveViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UITextFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *UITextFieldVerifyCode;
@property (weak, nonatomic) IBOutlet UITextField *UITextFieldPwd;
@property (weak, nonatomic) IBOutlet UIButton *mUIButtonGetCode;


@end
