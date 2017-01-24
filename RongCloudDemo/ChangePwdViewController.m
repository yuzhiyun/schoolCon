//
//  ChangePwdViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/24.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "Toast.h"
#import "AppDelegate.h"
@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ok:(id)sender {
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    
    if(0==_mUITextFieldOld.text.length||0==_mUITextFieldNew.text.length){
        
        [Toast showToast:@"请确保输入框不为空" view:self.view];
        
    }else if (![myDelegate.pwd isEqualToString:  _mUITextFieldOld.text]){
        [Toast showToast:@"旧密码输入错误" view:self.view];
    
    }else{
        NSLog(@"修改成功");
    }
    
    
    
    
}


@end
