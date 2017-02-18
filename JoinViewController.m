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

@implementation JoinViewController{
    int joinNum;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _mUILabelTitle.text=title;
    _mUILabelHost.text=host;
    _mUILabelDate.text=date;
    _mUILabelPlace.text=place;
    _mUILabelPrice.text=price;
    //默认是一个人
    joinNum=1;
    _mUILabelJoinNum.text=[NSString stringWithFormat:@"%i",joinNum];
    _mUITextFieldPhone.text=[DataBaseNSUserDefaults getData:@"phone"];
    
    //处理软键盘遮挡输入框事件
    _mUITextFieldPhone.delegate=self;
    _mUITextFieldRemark.delegate=self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pay:(id)sender {
    
    
    if(0==_mUITextFieldPhone.text.length||0==_mUITextFieldRemark.text.length){
        [Alert showMessageAlert:@"请确保输入框不为空" view:self];
        
        return;
    }
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
                                  @"peopleNumber":_mUILabelJoinNum.text,
                                  @"tel":_mUITextFieldPhone.text,
                                  @"remarks":_mUITextFieldRemark.text,
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
- (IBAction)minus:(id)sender {
    if(1==joinNum){
        [Alert showMessageAlert:@"参加人数不能少于1" view:self];
        return;
    }
        
    joinNum-=1;
    _mUILabelJoinNum.text=[NSString stringWithFormat:@"%i",joinNum];
    
    
}
- (IBAction)add:(id)sender {
    joinNum+=1;
    _mUILabelJoinNum.text=[NSString stringWithFormat:@"%i",joinNum];
}
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 2.模拟2秒后（
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    CGRect frame = textField.frame;
    int offset = frame.origin.y +frame.size.height - (self.view.frame.size.height - 300);//键盘高度270
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    
    // });
    
    
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
 //   keyBoardHeight = keyboardRect.size.height;
   // NSLog(@"%i",keyBoardHeight);
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
