//
//  EditPhoneViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "EditPhoneViewController.h"
#import "Toast.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Article.h"
#import "JsonUtil.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
#import "DataBaseNSUserDefaults.h"
#import "Alert.h"

@interface EditPhoneViewController ()

@end

@implementation EditPhoneViewController{
    
    //用于计算验证码等待秒数
    int count;
    NSTimer *countDownTimer;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count=60;
    // Do any additional setup after loading the view.
    
    [self.mUIButtonGetCode.layer setMasksToBounds:YES];
    
    
    [self.mUIButtonGetCode.layer setCornerRadius:4.0]; //设置圆角，数学不好，数值越小越不明显，自己找一个合适的值
   
    
    [self.mUIButtonGetCode.layer setBorderWidth:0.8];//设置边框的宽度
    
    [self.mUIButtonGetCode.layer setBorderColor:[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0] CGColor]];//设置颜色

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


- (IBAction)getVCode:(id)sender {
    
    if(!(count==60))
        return;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    // NSLog(myDelegate.pwd);
    
    if(0==_mUITextFieldNewPhone.text.length){
        
        [Toast showToast:@"请确保输入框不为空" view:self.view];
        return;
    }
    
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sys/sms/changephone",myDelegate.ipString];
    
    
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"phone":_mUITextFieldNewPhone.text
                                  };
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            if([[doc objectForKey:@"code"] isKindOfClass:[NSNumber class]])
                NSLog(@"code 是 NSNumber");
            //判断code 是不是0
            NSNumber *zero=[NSNumber numberWithInt:(0)];
            NSNumber *code=[doc objectForKey:@"code"];
            if([zero isEqualToNumber:code])
            {
                //陈涛 15084731465  64785
                [Alert showMessageAlert:@"验证码短信已经发送到你的手机" view:self];
                
                [self setSixtySecond ];
                
                
            }
            else{
                if([@"token invalid" isEqualToString:[doc objectForKey:@"msg"]]){
                    [AppDelegate reLogin:self];
                }
                else{
                    NSString *msg=[NSString stringWithFormat:@"code是%d ： %@",[doc objectForKey:@"code"],[doc objectForKey:@"msg"]];
                    [Alert showMessageAlert:msg  view:self];
                }
            }
        }
        else
            NSLog(@"*****doc空***********");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [self.tableView footerEndRefreshing];
        //        [self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        
        [Alert showMessageAlert:errorUser view:self];
    }];
}

-(void)setSixtySecond{
    
   
    //开始倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    

}
-(void)timeFireMethod{
    //倒计时-1
    count--;
    //修改倒计时标签现实内容
    [_mUIButtonGetCode setTitle:[NSString stringWithFormat:@"%d S",count] forState:UIControlStateNormal];
    //labelText.text=[NSString stringWithFormat:@"%d",secondsCountDown];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(count==0){
        [countDownTimer invalidate];
        count=60;
        [_mUIButtonGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}
- (IBAction)ok:(id)sender {
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    // NSLog(myDelegate.pwd);
    
    if(0==_mUITextFieldNewPhone.text.length|| 0==_mUITextFieldVCode.text.length){
        
        [Toast showToast:@"请确保输入框不为空" view:self.view];
        return;
    }
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sys/user/bind",myDelegate.ipString];
    
    
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"phone":_mUITextFieldNewPhone.text,
                                 @"vcode":_mUITextFieldVCode.text
                                  };
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            if([[doc objectForKey:@"code"] isKindOfClass:[NSNumber class]])
                NSLog(@"code 是 NSNumber");
            //判断code 是不是0
            NSNumber *zero=[NSNumber numberWithInt:(0)];
            NSNumber *code=[doc objectForKey:@"code"];
            if([zero isEqualToNumber:code])
            {
                //陈涛 15084731465  64785
                //[Alert showMessageAlert:@"修改手机号成功" view:self];
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"修改手机号成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                               NSLog(@"跳回LoginViewController");
                                                               LoginViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                                               nextPage->isFromTokenInValid=true;
                                                               [DataBaseNSUserDefaults setData:_mUITextFieldNewPhone.text forkey:@"phone"];
                                                               nextPage->phone=[DataBaseNSUserDefaults getData:@"phone"];
                                                               nextPage->pwd=[DataBaseNSUserDefaults getData:@"pwd"];
                                                               
                                                               [self.navigationController pushViewController:nextPage animated:YES];
                                                           }];
                
                //信息框添加按键
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else{
                [Alert showMessageAlert:[doc objectForKey:@"msg"] view:self];
            }
            
        }
        else
            NSLog(@"*****doc空***********");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [self.tableView footerEndRefreshing];
        //        [self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
         if(-1009==error.code||-1016==error.code)
            errorUser=@"主人，似乎没有网络喔！";
        
        [Alert showMessageAlert:errorUser view:self];
    }];
    
    
    

    
}

@end
