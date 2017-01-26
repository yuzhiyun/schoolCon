//
//  EntranceViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/26.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "EntranceViewController.h"
#import "LoginViewController.h"
#import "ChooseSchoolTableViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Alert.h"
#import "DataBaseNSUserDefaults.h"
@interface EntranceViewController ()

@end

@implementation EntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //全局ip
//    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
//    myDelegate.ipString=@"192.168.229.1";
//    NSLog(@"全局ip地址是 %@",myDelegate.ipString);
    
    
//    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //    隐藏返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=YES;
    
 
//    按钮设置边框
    [self.UIButtonLogin.layer setMasksToBounds:YES];
    [self.UIButtonActive.layer setMasksToBounds:YES];
    
    [self.UIButtonLogin.layer setCornerRadius:4.0]; //设置圆角，数学不好，数值越小越不明显，自己找一个合适的值
    [self.UIButtonActive.layer setCornerRadius:4.0];
    
    [self.UIButtonLogin.layer setBorderWidth:0.5];//设置边框的宽度
    
    [self.UIButtonLogin.layer setBorderColor:[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0] CGColor]];//设置颜色
    //    头像圆形
    //    self.UIImageViewAvatar.layer.masksToBounds = YES;
    //    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
    
    // Do any additional setup after loading the view.
    
    //    隐藏返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=YES;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self checkUserLogin];
}

-(void)checkUserLogin{
    
    
    
    id token=[DataBaseNSUserDefaults getData:@"token"];
    NSString *stringToken=(NSString *)token;
    if(token==nil){
        NSLog(@"token==nil,还未登录，什么事都不需要干");
//        UIAlertView *alert =
//        [[UIAlertView alloc] initWithTitle:nil
//                                   message:@"token==nil"
//                                  delegate:nil
//                         cancelButtonTitle:@"确定"
//                         otherButtonTitles:nil];
//        [alert show];
    }
    else{
        NSLog(@"token不是nil，把数据传给appDelegate,弹窗显示自动登录，然后进入首页");
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        myDelegate.token=stringToken;
        
        MBProgressHUD *hud;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
        hud.labelText = @"正在自动登录";
        [hud show:YES];
        
        // 2.模拟2秒后（
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hide:YES];
            
            //连接融云服务器
            [AppDelegate  loginRongCloud:[DataBaseNSUserDefaults getData:@"rtoken"]];
            MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            nextPage.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:nextPage animated:YES];
        });
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)setIp:(id)sender {
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"设置IP" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];

        myDelegate.ipString=mUITextFieldIp.text;
    }];
    
    [alert addAction:OK];
   [ alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        
        mUITextFieldIp=textField;
    
   }];
    [self  presentViewController:alert animated:YES completion:nil];
}


-(void) enterMain{
    MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)login:(id)sender {
    //根据storyboard id来获取目标页面
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    //    传值
    /**
     *根据index判断选择学校之后是登录还是激活还是修改密码
     */
    nextPage->index=1;
    
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    //    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)active:(id)sender {
    
//    [self enterMain];
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    nextPage->index=2;
    [self.navigationController pushViewController:nextPage animated:YES];
}
//虽然viewDidLoad已经设置了隐藏，但是在进入下一个页面并返回此页面的时候，还是会出现，所以在这里再次隐藏
-(void) viewDidAppear:(BOOL)animated{
    //    隐藏返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=YES;
}

@end
