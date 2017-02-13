//
//  SendMessageViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/14.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "SendMessageViewController.h"
#import "LinkMan.h"
#import <RongIMKit/RongIMKit.h>
#import "MainViewController.h"
#import "ContactViewController.h"
@interface SendMessageViewController ()

@end

@implementation SendMessageViewController{
    
    int flag;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    flag=0;
    NSLog(@"SendMessageViewController");
    for(LinkMan *model in dataSelectedLinkman){
        NSLog(model.LinkmanId);
        NSLog(model.name);
    }
    
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightButton;
    // Do any additional setup after loading the view.
    
    _UILabelReceiver.text=@"";
    _UILabelNumber.text=[NSString stringWithFormat:@"您将要发送消息给%i位朋友",[dataSelectedLinkman count] ];
    for(LinkMan *model in dataSelectedLinkman){
        
        _UILabelReceiver.text=[[_UILabelReceiver.text stringByAppendingString:model.name] stringByAppendingString:@" "];
        //        UITextViewMessage;
        
    }
    
    _UITextViewMessage.text=@"请输入消息";
    //    _UITextViewMessage.accessibilityHint=@"请输入消息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    //    _UITextViewMessage.text=@"请输入消息";
    if(![@"请输入消息" isEqualToString:   _UITextViewMessage.text]){
        
        
        
        for(int i=0;i<[dataSelectedLinkman count];i++ ){
            
            LinkMan *model =[dataSelectedLinkman objectAtIndex:i];
            NSString *content=_UITextViewMessage.text;
            
            //初始化文本消息
            RCTextMessage *txtMsg = [RCTextMessage messageWithContent:content];
            [[RCIMClient sharedRCIMClient]  sendMessage:ConversationType_PRIVATE targetId:model.LinkmanId content:txtMsg pushContent:content success:^(long messageId) {
                
                NSLog(@"给%@发送消息成功",model.name);
            } error:^(RCErrorCode nErrorCode, long messageId) {
                NSLog(@"群发失败！！！！");
                flag=1;
            }];
            //添加5人/次 程序，因为融云只支持每秒发送5次消息
            if(0==(i+1)%5){
                //什么事都不做，就是延迟一秒
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    NSLog(@"延迟一秒钟");
                   
                });

                
            }
        }
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"群发成功,点击确认回到主页" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                       
                                                       NSLog(@"跳回主页面");
                                                       
                                                       MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                                                       
                                                       [self.navigationController pushViewController:nextPage animated:YES];
                                                       
                                                   }];
        
        //        信息框添加按键
        [alert addAction:ok];
        
        
        
        if(1==flag){
            [alert setMessage:@"发送失败，请检查网络或者重启应用"];
            [self presentViewController:alert animated:YES completion:nil];
        }else
            [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"请先在输入框输入消息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        
        //        信息框添加按键
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
}





@end
