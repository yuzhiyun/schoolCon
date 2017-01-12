//
//  ActiveViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//
#import "ActiveViewController.h"
#import "MainViewController.h"
#import "SetPwdAfterActiveViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Toast.h"
#import "JsonUtil.h"
//#define JsonGet @"http://192.168.229.1:8080/schoolCon/api/sys/sms/send?appId=03a8f0ea6a&appSecret=b4a01f5a7dd4416c&phone=12345&1564do12spa"
@interface ActiveViewController ()

@end

@implementation ActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"激活";
    //全局ip
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSLog(@"全局ip地址是 %@",myDelegate.ipString);
    
    //处理软键盘遮挡输入框事件
    _UITextFieldPhone.delegate=self;
    _UITextFieldPwd.delegate=self;
    _UITextFieldVerifyCode.delegate=self;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
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
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/sms/validate",myDelegate.ipString];
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
//    NSDictionary *parameters = @{
//                                 @"appId":myDelegate.appId,
//                                 @"appSecret":myDelegate.appSecret,
//                                 @"schoolId":myDelegate.schoolId,
//                                 @"phone":@"123456",
//                                 @"pwd":@"123456",
//                                 @"vcode":@"1234"
//                                 };
    
    
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
        
        
        
        //
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



- (IBAction)active:(id)sender {
    
    if(_UITextFieldPhone.text.length == 0||_UITextFieldPwd.text.length==0||_UITextFieldVerifyCode==0){
      
        [Toast showToast:@"确保输入框不为空" view:self.view];
//        NSLog(@"手机号不能为空");
    }
    
    else
    
    
    [self httpActive];
//    SetPwdAfterActiveViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"SetPwdAfterActiveViewController"];
//    nextPage.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:nextPage animated:YES];
    
}

-(void)httpActive{
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
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/user/activate",myDelegate.ipString];
    
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
                                 @"pwd":_UITextFieldPwd.text,
                                 @"vcode":_UITextFieldVerifyCode.text
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
            
            //激活成功之后获取token
            AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
            myDelegate.token=[[doc objectForKey:@"data"]objectForKey:@"token"];
            
            [self setData:myDelegate.token forkey:@"token"];
        
            MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            nextPage.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:nextPage animated:YES];
        }
        else
        {
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

//NSUserDefaults 存数据
-(void) setData:(id) object forkey:(NSString*) forkey{
    //取得定义
    NSUserDefaults *tUserDefaults=[NSUserDefaults standardUserDefaults];
    //存放数据
    [tUserDefaults setObject:object forKey:forkey];
    //确认数据
    [tUserDefaults synchronize];
}

//发送验证码
- (IBAction)getCode:(id)sender {
    
    if(_UITextFieldPhone.text.length == 0){
        [Toast showToast:@"手机号不能为空" view:self.view];
        NSLog(@"手机号不能为空");
    }
    else
        [self httpGetVerifyCode];

}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y +frame.size.height - (self.view.frame.size.height - 270);//键盘高度270
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


@end



