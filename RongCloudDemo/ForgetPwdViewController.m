//
//  ChangePwdViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "SetNewPwdViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "Toast.h"
#import "JsonUtil.h"
@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"忘记密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePwd:(id)sender {
    
    if(_UITextFieldPhone.text.length == 0||_UITextFieldNewPwd.text.length==0||_UITextFieldVerifyCode==0){
        
        [Toast showToast:@"确保输入框不为空" view:self.view];
    }
    else
        [self httpChangePwd];
}

-(void)httpChangePwd{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/user/forget",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
    NSDictionary *parameters = @{
                                 @"appId":myDelegate.appId,
                                 @"appSecret":myDelegate.appSecret,
                                 @"schoolId":myDelegate.schoolId,
                                 @"phone":_UITextFieldPhone.text,
                                 @"pwd":_UITextFieldNewPwd.text,
                                 @"vcode":_UITextFieldVerifyCode.text
                                 };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
//        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        /**
         *开始解析json
         */
        
        
        
        //
        //        //NSString *result=[self DataTOjsonString:responseObject];
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //        {
        //         "msg" : "激活失败,该账号已经进行过激活",
        //         "code" : 205
        //         }
        NSLog(@"服务器返回msg%@",[doc objectForKey:@"msg"]);
        NSLog(@"服务器返回code%i",[doc objectForKey:@"code"]);
        if([[doc objectForKey:@"msg"]isEqualToString:@"ok"]){
            
            NSLog(@"修改密码成功");
            hud.labelText = @"修改密码成功，正在前往登录页面。";
            // 2.模拟2秒后（
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hide:YES];
                LoginViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                nextPage.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:nextPage animated:YES];
            });
        }
        else
        {
            [hud hide:YES];
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:[doc objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
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

- (IBAction)getVerifyCode:(id)sender {
    
    if(_UITextFieldPhone.text.length == 0){
        [Toast showToast:@"手机号不能为空" view:self.view];
    }
    else
        [self httpGetVerifyCode];
    
}

//获取验证码
-(void)httpGetVerifyCode{
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
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/sms/change",myDelegate.ipString];
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
    NSDictionary *parameters = @{
                                 @"appId":myDelegate.appId,
                                 @"appSecret":myDelegate.appSecret,
                                 @"schoolId":myDelegate.schoolId,
                                 @"phone":_UITextFieldPhone.text
                                 };
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        /**
         *开始解析json
         */
        //        //NSString *result=[self DataTOjsonString:responseObject];
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //        {
        //         "msg" : "激活失败,该账号已经进行过激活",
        //         "code" : 205
        //         }
        NSLog([doc objectForKey:@"msg"]);
        NSLog(@"%i",[doc objectForKey:@"code"]);
        if([@"ok" isEqualToString:[doc objectForKey:@"msg"]])
        {

            [Toast showToast:@"短信已经发送" view:self.view];
        }
        else{
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message: [doc objectForKey:@"msg"]preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                       style:UIAlertActionStyleDefault handler:nil];
            //信息框添加按键
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



@end
