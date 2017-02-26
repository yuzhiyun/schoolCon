//
//  TestIntroductionViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/13.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "TestIntroductionViewController.h"
#import "TestViewController.h"
#import "AppDelegate.h"
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
@interface TestIntroductionViewController (){
    
//    NSString *isPaySuccess;

}

@end

@implementation TestIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//   isPaySuccess=@"0";
    
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    /**
     *显示网页
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString=[NSString stringWithFormat:@"%@/api/psy/test/getObject",myDelegate.ipString];
    NSURL *url = [NSURL URLWithString: urlString];
    NSString *body = [NSString stringWithFormat: @"id=%@&token=%@&appId=%@&appSecret=%@", testId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [_UIWebViewtest loadRequest: request];
 
    //如果金额为0，无需支付
//    if([money isEqualToNumber:[NSNumber numberWithInt:(0)]]){
    
        
       // [_mUIButtonPay setTitle:@"开始测试" forState:UIControlStateNormal];
//    }
    [_mUIButtonPay setTitle:@"开始测试" forState:UIControlStateNormal];
    
//    [DataBaseNSUserDefaults setData: @"testId" forkey:@"testId"];
//    [DataBaseNSUserDefaults setData: @"testName" forkey:@"testName"];
//    [DataBaseNSUserDefaults setData: @"picUrl" forkey:@"picUrl"];
//
//    // Do any additional setup after loading the view.
    
    [DataBaseNSUserDefaults setData: @"0" forkey:@"isPaySuccess"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)afterPaySuccess{
//    
//    NSLog(@"afterPaySuccess被调用了afterPaySuccess被调用了afterPaySuccess被调用了");
//    [_mUIButtonPay setTitle:@"开始测试" forState:UIControlStateNormal];
//    isPaySuccess=true;
//}

-(void) jumpToTestViewController{
    TestViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
    //nextPage->testId=testId;
    nextPage->testId=testId;
    nextPage->testName=testName;
    nextPage->picUrl=picUrl;
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}
- (IBAction)startTest:(id)sender {
    
    
    
    //如果金额为0，无需支付
    if([money isEqualToNumber:[NSNumber numberWithInt:(0)]]){
        [self jumpToTestViewController];
    }else{
        if([@"1" isEqualToString:[DataBaseNSUserDefaults getData:@"isPaySuccess"]]){
            [self jumpToTestViewController];
        }else{
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"使用微信支付付费" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                           
                                                           if([WXApi isWXAppInstalled]){
                                                               
                                                              [self getWeXinUnionPayParameters];
                                                           }
                                                           else
                                                           {
                                                               [Alert showMessageAlert:@"抱歉，您的手机还没有安装微信，无法使用微信支付" view:self];
                                                           }
                                                           
                                                           
                                                       }];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                               
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                           }];
            //        信息框添加按键
            [alert addAction:ok];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
        
        }
        
        
    }
}

//获取服务器端访问微信统一接口之后的参数，以便用于吊起微信支付
-(void) getWeXinUnionPayParameters{
    
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @"正在跳转...";
    [hud show:YES];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString= [NSString stringWithFormat:@"%@/api/order/test/orderStart",myDelegate.ipString];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    //避免乱码
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *token=myDelegate.token;
    // 请求参数
    
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"testId":testId,
                                  @"testName":testName,
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
                
                //存储以便在验证微信支付的时候使用
                [DataBaseNSUserDefaults setData: [[doc objectForKey:@"data"]objectForKey:@"orderId"] forkey:@"orderId"];
                [DataBaseNSUserDefaults setData: @"xinli" forkey:@"orderType"];
                
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
                    
                    
                    NSNumber *isAlreadyPayed=[NSNumber numberWithInt:(101)];
                    NSNumber *code=[doc objectForKey:@"code"];
                    if([isAlreadyPayed isEqualToNumber:code]){
                    
                        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"查询到您已经付费过了，点击确认即可开始再次测试，" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                                   style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                                     [self jumpToTestViewController];
                                                                   }];
                        
                        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消"
                                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                                           
                                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                                       }];
                        //        信息框添加按键
                        [alert addAction:ok];
                        [alert addAction:cancel];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                        return ;
                    }
                    NSString *msg=[NSString stringWithFormat:@"code是%d ： %@",[doc objectForKey:@"code"],[doc objectForKey:@"msg"]];
                    [Alert showMessageAlert:msg  view:self];
                    
                    //[self jumpToTestViewController];
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
