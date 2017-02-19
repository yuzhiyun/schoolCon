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
    if(0==indexPath.row)
     [self getWeXinUnionPayParameters:@"183"];
    else
      [self getWeXinUnionPayParameters:@"366"];
    //[self wechatPay];
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

-(void) wechatPay{
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                /*
                partnerid
                prepayid
                noncestr
                timestamp
                package
                sign
                 */
                //return @"";
            }else{
                NSLog( [dict objectForKey:@"retmsg"]);
               // return [dict objectForKey:@"retmsg"];
            }
        }else{
            NSLog(@"服务器返回错误，未获取到json对象");
            //return @"服务器返回错误，未获取到json对象";
        }
    }else{
        NSLog(@"服务器返回错误");
       // return @"服务器返回错误";
    }

}

@end
