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
@interface LinkmanTableViewController ()

@end

@implementation LinkmanTableViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataRemark;
    NSMutableArray *mDataAvatar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mDataUsername=[[NSMutableArray alloc]init];
    [mDataUsername addObject:@"俞志云"];
    [mDataUsername addObject:@"马小龙"];
    [mDataUsername addObject:@"孙萌"];
    [mDataUsername addObject:@"吴晓茎"];
    [mDataUsername addObject:@"秦启飞"];
    
    mDataRemark=[[NSMutableArray alloc]init];
    [mDataRemark addObject:@"化学教师"];
    [mDataRemark addObject:@"数学教师"];
    [mDataRemark addObject:@"英语教师"];
    [mDataRemark addObject:@"语文教师"];
    [mDataRemark addObject:@"生物教师"];
    
    mDataAvatar=[[NSMutableArray alloc]init];
    [mDataAvatar addObject:@"1.jpg"];
    [mDataAvatar addObject:@"2.jpg"];
    [mDataAvatar addObject:@"3.jpg"];
    [mDataAvatar addObject:@"4.jpg"];
    [mDataAvatar addObject:@"5.jpg"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [mDataUsername count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    LinkmanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[LinkmanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.UILabelName.text = [mDataUsername objectAtIndex:indexPath.row];
    cell.UILabelRemark.text = [mDataRemark objectAtIndex:indexPath.row];
    cell.UIImgAvatar.image=[UIImage imageNamed:[mDataAvatar objectAtIndex:indexPath.row]];
    cell.UIImgAvatar.layer.masksToBounds = YES;
    cell.UIImgAvatar.layer.cornerRadius = cell.UIImgAvatar.frame.size.height / 2 ;
    
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = [mDataUsername objectAtIndex:indexPath.row];
    //设置聊天会话界面要显示的标题
    chat.title = [mDataUsername objectAtIndex:indexPath.row];
    //设置隐藏底部栏
    chat.hidesBottomBarWhenPushed=YES;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];

}


@end
