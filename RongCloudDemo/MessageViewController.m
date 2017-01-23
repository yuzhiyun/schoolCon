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
    
    /**
     *要显示用户信息和群组信息，首先需要实现两个协议，然后设置代理为这个类，然后实现两个函数
     *- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
     *- (void)getGroupInfoWithGroupId:(NSString *)groupId
     *completion:(void (^)(RCGroup *groupInfo))completion{
     */
    [RCIM sharedRCIM].userInfoDataSource=self;
    [RCIM sharedRCIM].groupInfoDataSource=self;
    
    //设置需要显示哪些类型的会话,加了这行代码，群的消息就显示出来了，否则默认只显示单聊消息（我的猜测吧！）
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
 获取用户信息
 @param userId                  用户ID
 @param completion              获取用户信息完成之后需要执行的Block
 @param userInfo(in completion) 该用户ID对应的用户信息
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
//    if([@"1" isEqualToString:userId]){
//        RCUserInfo *userInfo=[[RCUserInfo alloc]initWithUserId:userId name:@"本人" portrait:@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg"];
//        completion(userInfo);
//        
//    }
    if([@"321" isEqualToString:userId]){
        RCUserInfo *userInfo2=[[RCUserInfo alloc]initWithUserId:userId name:@"俞志云" portrait:@"http://avatar.csdn.net/B/A/4/1_yuzhiyun3536.jpg"];
        completion(userInfo2);
    }
    
    
    
}
/*!
 获取群组信息
 
 @param groupId                     群组ID
 @param completion                  获取群组信息完成之后需要执行的Block
 @param groupInfo(in completion)    该群组ID对应的群组信息
 @discussion SDK通过此方法获取用户信息并显示，请在completion的block中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion{
    
    //我自己建的群id就是1，所以
    if([@"1" isEqualToString:groupId]){
        RCGroup *groupInfo =[[RCGroup alloc] initWithGroupId:@"1" groupName:@"初二3班班群" portraitUri:@"http://img.blog.csdn.net/20170113192304511?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveXV6aGl5dW4zNTM2/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast"];
        completion(groupInfo);
    }
    
}
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
    
    //修改未读消息红色圆点的数字大小（我指的是在手机桌面上的圆点）
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber -   model.unreadMessageCount;
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    //设置隐藏底部栏
    conversationVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    ////我重写会话列表的点击事件是为了让聊天界面不显示底部栏。
    //    NSLog(@"targetId 是会话目标id   %@",model.targetId );
    ////     senderUserId是会话中最后一条消息的发送者用户ID
    //    NSLog( @"senderUserId是会话中最后一条消息的发送者用户ID,那么单聊的话就是 发送者id   %@",model.senderUserId );
    //    if(conversationModelType==ConversationType_PRIVATE){
    //    //新建一个聊天会话View Controller对象
    //    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    //    chat.conversationType = ConversationType_PRIVATE;
    //    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    //    chat.targetId = model.senderUserId;
    //    //设置聊天会话界面要显示的标题
    //    chat.title = model.senderUserId;
    //    //设置隐藏底部栏
    //    chat.hidesBottomBarWhenPushed=YES;
    //    //显示聊天会话界面
    //    [self.navigationController pushViewController:chat animated:YES];
    //    }
}


/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
//{
//    //此处为了演示写了一个用户信息
//    if ([@"1" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"1";
//        user.name = @"测试1";
//        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
//
//        return completion(user);
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
