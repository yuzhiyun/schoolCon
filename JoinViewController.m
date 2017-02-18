//
//  JoinViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "JoinViewController.h"
#import "VipViewController.h"
#import "DataBaseNSUserDefaults.h"
#import "AppDelegate.h"
#import "Alert.h"
#import "AFNetworking.h"
#import "Toast.h"
#import "ChangePwdViewController.h"
#import "JsonUtil.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "MBProgressHUD.h"
@interface JoinViewController ()

@end

@implementation JoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pay:(id)sender {
    
    
    
    [self getWeXinUnionPayParameters];
    
    
}

//获取服务器端访问微信统一接口之后的参数，以便用于吊起微信支付
-(void) getWeXinUnionPayParameters{
    
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @"正在跳转...";
    [hud show:YES];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString= [NSString stringWithFormat:@"%@/api/order/activity/orderStart",myDelegate.ipString];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    //避免乱码
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *token=myDelegate.token;
    // 请求参数
    
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  
                                  @"activityId":activityId,
                                  @"activityType":activityType,
                                  @"activityName":activityName,
                                  @"picurl":picurl,
                                  @"peopleNumber":@"1",
                                  @"tel":@"12345678901",
                                  @"remarks":@"备注",
                                  @"payType":@"wx"

                                  };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hide:YES];
        
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果*******获取服务器端访问微信统一接口之后的参数，以便用于吊起微信支付****************");
        NSLog(result);
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            //判断code 是不是0
            NSNumber *zero=[NSNumber numberWithInt:(0)];
            NSNumber *code=[doc objectForKey:@"code"];
            if([zero isEqualToNumber:code])
            {
                //调起微信支付
                PayReq* req              = [[PayReq alloc] init];
                //商户号
                req.partnerId           = [[doc objectForKey:@"data"]objectForKey:@"partnerid"];
                
                req.prepayId            = [[doc objectForKey:@"data"]objectForKey:@"prepayid"];
                
                req.nonceStr            = [[doc objectForKey:@"data"]objectForKey:@"noncestr"];
                
                NSString *timeStamp     = [[doc objectForKey:@"data"]objectForKey:@"timestamp"];
                //[UInt32
                req.timeStamp           =timeStamp.intValue;
                 
                 req.package             = [[doc objectForKey:@"data"]objectForKey:@"package"];
                
                req.sign                = [[doc objectForKey:@"data"]objectForKey:@"sign"];
                
                NSLog(req.partnerId);
                NSLog(req.prepayId);
                NSLog(req.nonceStr);
               // NSLog(@"%@", req.timeStamp);
                NSLog(req.package);
                NSLog(req.sign);
                [WXApi sendReq:req];
                
               
                
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
        
        [hud hide:YES];
        
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(-1009==error.code||-1016==error.code)
            
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
    
    
}

@end
