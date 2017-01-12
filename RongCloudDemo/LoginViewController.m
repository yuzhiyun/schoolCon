//
//  LoginViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/24.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "MainViewController.h"
#import "ChooseSchoolTableViewController.h"
#import "ForgetPwdViewController.h"
#import "AFNetworking.h"
//#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ForgetPwdViewController.h"
#import "Toast.h"
#import "DataBaseNSUserDefaults.h"
#define JsonGet @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    //    头像圆形
    self.UIImageViewAvatar.layer.masksToBounds = YES;
    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
    
    //    隐藏返回按钮navigationController的navigationBar
    //    self.navigationController.navigationBarHidden=YES;
    
    //    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)login:(id)sender {
    
    if(0==_UITextFieldUserName.text.length||0==_UITextFieldPwd.text.length)
//        [self toast:@"用户名密码不能为空"];
        [Toast showToast:@"用户名密码不能为空" view:self.view];
    else
        [self httpLogin];
    
    
}
//-(void)toast:(NSString *)str
//
//{
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.labelText = str;
//    HUD.mode = MBProgressHUDModeText;
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        
//        sleep(1);
//        
//    } completionBlock:^{
//        
//        [HUD removeFromSuperview];
//    }];
//}

//登录
-(void)httpLogin{
    //#import "AFNetworking.h"
    //#import "AppDelegate.h"
    //#import "MBProgressHUD.h"
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/user/login",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    
    NSString *userName=@"123456";
    NSString *pwd=@"12345";
    
    userName=_UITextFieldUserName.text;
    pwd=_UITextFieldPwd.text;
    
    
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"appId":myDelegate.appId,
                                 @"appSecret":myDelegate.appSecret,
                                 @"schoolId":myDelegate.schoolId,
                                 //                                 @"loginname":@"superadmin",
                                 @"loginname":userName,
                                 //                                 @"vcode":@"1234",
                                 @"pwd":pwd
                                 };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[self DataTOjsonString:responseObject];
        
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        /**
         *开始解析json
         */
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //        {
        //         "msg" : "激活失败,该账号已经进行过激活",
        //         "code" : 205
        //         }
        NSLog([doc objectForKey:@"msg"]);
        NSLog(@"%i",[doc objectForKey:@"code"]);
        //如果登录成功
        if([@"ok" isEqualToString:[doc objectForKey:@"msg"]])
        {
            //登录之后获取token
            AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
            myDelegate.token=[[doc objectForKey:@"data"]objectForKey:@"token"];
            
            NSLog(@"登录之后存储token%@",myDelegate.token);
            [DataBaseNSUserDefaults setData: myDelegate.token forkey:@"token"];
            
            MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            nextPage.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:nextPage animated:YES];
            
        }
        else{
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message: [doc objectForKey:@"msg"]preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                       style:UIAlertActionStyleDefault handler:nil];
            
            //        信息框添加按键
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:errorUser preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (IBAction)forgetPwd:(id)sender {
    ForgetPwdViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
    [self.navigationController pushViewController:nextPage animated:YES];
}

//- (IBAction)active:(id)sender {
//    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
//    nextPage->index=2;
//    [self.navigationController pushViewController:nextPage animated:YES];
//}
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}








@end
