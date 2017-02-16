//
//  LoginViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/24.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
@public
    //判断是否是因为TokenInValid才跳转到这个界面的
    Boolean isFromTokenInValid;
    
    
@public
    //发生TokenInValid的界面传值过来
    NSString *phone;
@public
    NSString *pwd;
}
@property (weak, nonatomic) IBOutlet UIImageView *UIImageViewAvatar;
@property (weak, nonatomic) IBOutlet UITextField *UITextFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *UITextFieldPwd;

@end
