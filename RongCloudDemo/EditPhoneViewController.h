//
//  EditPhoneViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mUITextFieldNewPhone;
@property (weak, nonatomic) IBOutlet UITextField *mUITextFieldVCode;

@property (weak, nonatomic) IBOutlet UIButton *mUIButtonOk;

@property (weak, nonatomic) IBOutlet UIButton *mUIButtonGetCode;

@end
