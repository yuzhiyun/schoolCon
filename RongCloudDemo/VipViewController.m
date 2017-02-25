//
//  VipViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "VipViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "AFNetworking.h"
#import "Alert.h"
#import "MBProgressHUD.h"
#import "JsonUtil.h"
#import "DataBaseNSUserDefaults.h"
#import "AppDelegate.h"
@interface VipViewController ()

@end

@implementation VipViewController{
    NSMutableArray  *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    data=[[NSMutableArray alloc]init];
    [data addObject:@"一个学期¥60"];
    [data addObject:@"一个学年¥120"];
    //[data addObject:@"自定义时间"];
    // Do any additional setup after loading the view.
    
    [self getVipInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //366  183
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *mUILabel=(UILabel*)[cell viewWithTag:1];
    mUILabel.text=[data objectAtIndex:indexPath.row];
    //    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
    //    cell.detailTextLabel.text=@"2017/12/21";
    //    //    cell.tes
    //
    //    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"请确保您安装了微信，并使用微信支付付费" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                   
                                                   
                                                   if([WXApi isWXAppInstalled]){
                                                   
                                                       
                                                       if(0==indexPath.row)
                                                           [self getWeXinUnionPayParameters:@"183"];
                                                       else
                                                           [self getWeXinUnionPayParameters:@"366"];
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
//获取服务器端访问微信统一接口之后的参数，以便用于吊起微信支付
-(void) getWeXinUnionPayParameters:(NSString *)continueDays{
    
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @"正在跳转...";
    [hud show:YES];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString= [NSString stringWithFormat:@"%@/api/order/vip/continueVip",myDelegate.ipString];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    //避免乱码
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *token=myDelegate.token;
    // 请求参数
    
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"continueDays":continueDays,
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
                
                [DataBaseNSUserDefaults setData: @"vip" forkey:@"orderType"];
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

//获取用户vip信息
-(void) getVipInfo{
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sys/user/myVip",myDelegate.ipString];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token
                                  };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
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
                _mUILabelWelcome.text=[[doc objectForKey:@"data"]objectForKey:@"nickname"];
                
                BOOL *isVip=[[[doc objectForKey:@"data"]objectForKey:@"isVip"] boolValue];
                
                //NSLog([[doc objectForKey:@"data"]objectForKey:@"isVip"]);
                if(!isVip){
                    _mUILabelExpireDate.text=@"已到期";
                    _mUILabelExpireDaysNum.text=@"0 天";
                }else{
                    /**
                     *把时间搓NSNumber 转成用户看得懂的时间
                     */
                    NSNumber *date=[[doc objectForKey:@"data"]objectForKey:@"vipEndTime"];
                    NSString *timeStamp2 =date.stringValue;
                    long long int date1 = (long long int)[timeStamp2 intValue];
                    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
                    //用于格式化NSDate对象
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    //设置格式：zzz表示时区
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    //NSDate转NSString
                    NSString *currentDateString = [dateFormatter stringFromDate:date2];
                    _mUILabelExpireDate.text=currentDateString;
                    
                    
                    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
                    //NSNumber *nDataNow=[datenow timeIntervalSince1970];
                    NSLog(@"%i",(int)[datenow timeIntervalSince1970]);
                    int expiresDays=(date.intValue -(int)[datenow timeIntervalSince1970])/(24*60*60);
                    _mUILabelExpireDaysNum.text=[NSString stringWithFormat:@"%i 天",expiresDays ];
                    
                    
                    
                }
                
                
                
                
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
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(-1009==error.code||-1016==error.code)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}
@end
