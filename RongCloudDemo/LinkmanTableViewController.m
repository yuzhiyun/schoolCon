//
//  LinkmanTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "LinkmanTableViewController.h"
#import "LinkmanTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
#import "LinkMan.h"
#import "UIImageView+WebCache.h"
@interface LinkmanTableViewController ()

@end

@implementation LinkmanTableViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataRemark;
    NSMutableArray *mDataAvatar;
    
    NSMutableArray *allDataFromServer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allDataFromServer=[[NSMutableArray alloc]init];
    

    
    LinkMan *model=[[LinkMan alloc]init];
    model.type=@"private";
    model.LinkmanId=@"321";
    model.picUrl=@"http://avatar.csdn.net/B/A/4/1_yuzhiyun3536.jpg";
    model.name=@"俞志云";
    model.introduction=@"化学教师";
    
    
    LinkMan *model2=[[LinkMan alloc]init];
    model2.type=@"private";
    model2.LinkmanId=@"1";
    model2.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    model2.name=@"马小龙";
    model2.introduction=@"数学教师";
    
    LinkMan *group=[[LinkMan alloc]init];
    group.type=@"group";
    group.LinkmanId=@"1";
    group.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    group.name=@"初二3班班群";
    group.introduction=@"";
    allDataFromServer=[[NSMutableArray alloc]init];
    [allDataFromServer addObject:model];
    [allDataFromServer addObject:model2];
    [allDataFromServer addObject:group];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [allDataFromServer count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    LinkmanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[LinkmanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
    cell.UILabelName.text =model.name;
    cell.UILabelRemark.text = model.introduction;
    //    cell.UIImgAvatar.image=[UIImage imageNamed:[mDataAvatar objectAtIndex:indexPath.row]];
    if([@"private" isEqualToString: model.type]){
        [cell.UIImgAvatar sd_setImageWithURL:model.picUrl placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    }
    else
        cell.UIImgAvatar.image=[UIImage imageNamed:@"group.png"];
    cell.UIImgAvatar.layer.masksToBounds = YES;
    cell.UIImgAvatar.layer.cornerRadius = cell.UIImgAvatar.frame.size.height / 2 ;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
    if([@"private" isEqualToString: model.type]){
        //新建一个聊天会话View Controller对象
        RCConversationViewController *chat = [[RCConversationViewController alloc]init];
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
        chat.conversationType = ConversationType_PRIVATE;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
        chat.targetId =model.LinkmanId;
        //设置聊天会话界面要显示的标题
        chat.title = model.name;
        //设置隐藏底部栏
        chat.hidesBottomBarWhenPushed=YES;
        //显示聊天会话界面
        [self.navigationController pushViewController:chat animated:YES];
    }
    else{
//        LinkMan *group=[[LinkMan alloc]init];
//        group.type=@"group";
//        group.LinkmanId=@"1";
//        group.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
//        group.name=@"初二3班班群";
//        group.introduction=@"";
        NSLog(@"群聊");
        //新建一个聊天会话View Controller对象
        RCConversationViewController *chat = [[RCConversationViewController alloc]init];
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
        chat.conversationType = ConversationType_GROUP;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
        chat.targetId = model.LinkmanId;
        //设置聊天会话界面要显示的标题
        chat.title = model.name;
        //设置隐藏底部栏
        chat.hidesBottomBarWhenPushed=YES;
        //显示聊天会话界面
        [self.navigationController pushViewController:chat animated:YES];
    }
}


@end
