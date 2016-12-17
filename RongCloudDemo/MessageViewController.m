//
//  MessageViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 点击事件的回调


/*!
 点击会话列表中Cell的回调
 
 @param conversationModelType   当前点击的会话的Model类型
 @param model                   当前点击的会话的Model
 @param indexPath               当前会话在列表数据源中的索引值
 
 @discussion 您需要重写此点击事件，跳转到指定会话的聊天界面。
 如果点击聚合Cell进入具体的子会话列表，在跳转时，需要将isEnteredToCollectionViewController设置为YES。
 */
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
//我重写会话列表的点击事件是为了让聊天界面不显示底部栏。
    
    NSLog(@"targetId 是会话目标id ",model.targetId );
//     senderUserId是会话中最后一条消息的发送者用户ID
    NSLog( @"senderUserId是会话中最后一条消息的发送者用户ID,那么单聊的话就是 发送者id ",model.senderUserId );

    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = model.senderUserId;
    //设置聊天会话界面要显示的标题
    chat.title = model.senderUserId;
    //设置隐藏底部栏
    chat.hidesBottomBarWhenPushed=YES;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end