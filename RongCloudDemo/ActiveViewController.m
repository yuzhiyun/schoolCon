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
    
//    ipString
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
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

#pragma mark 请求数据
-(void)loadData{
    
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/sms/send?appId=03a8f0ea6a&appSecret=b4a01f5a7dd4416c&phone=12345&1564do12spa",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    /*
     第一个参数：请求的地址
     第二个参数：需要传给服务端的参数
     第三个参数：数据请求成功回调的block >>>成功后的数据：responseObject
     第四个参数：数据请求失败回调的block >>>失败后的原因：error
     */
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud show:NO];
        
        
NSLog([self DataTOjsonString:responseObject]);
//        NSLog([self DataTOjsonString:responseObject]);
//          NSLog([self convertToJsonData:dic]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"访问错误%@",error]preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"访问错误%@",error);
    }];
}



- (IBAction)active:(id)sender {
    
    SetPwdAfterActiveViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"SetPwdAfterActiveViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
    
}
//发送验证码
- (IBAction)getCode:(id)sender {
    
    [self loadData];
    
    
}


@end
