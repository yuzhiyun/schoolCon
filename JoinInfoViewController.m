//
//  JoinInfoViewController.m
//  SchoolCon
//
//  Created by 秦启飞 on 2017/3/2.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "JoinInfoViewController.h"
#import "Alert.h"
#import "AFNetworking.h"
#import "Toast.h"
#import "ChangePwdViewController.h"
#import "JsonUtil.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface JoinInfoViewController ()

@end

@implementation JoinInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) loadData{
    
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @"正在跳转...";
    [hud show:YES];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString= [NSString stringWithFormat:@"%@/api/rcd/activity/getOrderInf",myDelegate.ipString];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    //避免乱码
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *token=myDelegate.token;
    // 请求参数
    
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"orderId":myActivityOrderId
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
                
                NSDictionary *dicOrder=[[doc objectForKey:@"data"] objectForKey:@"order"];
                
                NSDictionary *dicActivity=[[doc objectForKey:@"data"] objectForKey:@"activity"];
                
                
                
                self.mUILabelTitle.text=dicActivity[@"title"];
                self.mUILabelPublisher.text=dicActivity[@"author"];
                self.mUILabelPlace.text=dicActivity[@"place"];
                self.mUILabelPubPhone.text=dicActivity[@"tel"];
                NSNumber *startTime=dicActivity[@"startTime"];
                
                self.mUILabelDate.text=[ AppDelegate unicodedateToString:startTime];
                
                
                
                self.mUILabelPhone.text=dicOrder[@"tel"];
                NSNumber *joinNum=dicOrder[@"peopleNumber"];
                self.mUILabelJoinNumber.text=joinNum.stringValue;
                self.mUILabelPhone.text=dicOrder[@"tel"];
                self.mUILabelName.text=dicOrder[@"remarks"];
                
                NSNumber *fee=dicOrder[@"fee"];
                self.mUILabelFee.text=fee.stringValue;

                
                
                
                
                
                
                
                
                
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
