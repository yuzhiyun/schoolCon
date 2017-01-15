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
    for(LinkMan *model in dataSelectedLinkman){
        NSString *content=@"这是群发的消息";
        //初始化文本消息
        RCTextMessage *txtMsg = [RCTextMessage messageWithContent:content];
        [[RCIMClient sharedRCIMClient]  sendMessage:ConversationType_PRIVATE targetId:model.LinkmanId content:txtMsg pushContent:content success:^(long messageId) {
//            [alert setMessage:@"发送成功"];
//            [alert show];
            NSLog(@"给%@发送消息成功",model.name);
        } error:^(RCErrorCode nErrorCode, long messageId) {
            NSLog(@"群发失败！！！！");
            flag=1;
            
        }];

    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"群发成功,点击确认回到主页" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                   
                                                   // 模拟2秒后刷新
//                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   
                                                       NSLog(@"跳回主页面");
                                                       MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                                                       [self.navigationController pushViewController:nextPage animated:YES];
                                        
                                                       
//                                                   });
                                                   
                                                   

                                               }];
    
    //        信息框添加按键
    [alert addAction:ok];
    
    

    if(1==flag){
    [alert setMessage:@"发送失败，请检查网络或者重启应用"];
[self presentViewController:alert animated:YES completion:nil];
    }else
        [self presentViewController:alert animated:YES completion:nil];
    
}


    


@end
