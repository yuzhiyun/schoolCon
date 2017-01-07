//
//  GroupSendViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "GroupSendViewController.h"
#import "GroupSendTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
@interface GroupSendViewController ()

@end

@implementation GroupSendViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataRemark;
    NSMutableArray *mDataAvatar;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"群发";
    
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightButton;
    
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
    
    GroupSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[GroupSendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.UILabelName.text = [mDataUsername objectAtIndex:indexPath.row];
    cell.UILabelRemark.text = [mDataRemark objectAtIndex:indexPath.row];
    cell.UIImgAvatar.image=[UIImage imageNamed:[mDataAvatar objectAtIndex:indexPath.row]];
    cell.UIImgAvatar.layer.masksToBounds = YES;
    cell.UIImgAvatar.layer.cornerRadius = cell.UIImgAvatar.frame.size.height / 2 ;
    
    
//    cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"selected2.png"];

    return cell;
}

//把checkbox的图标改成被选中的
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GroupSendTableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //    cell.UIButtonCheckbox.
    cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"1.jpg"];
    NSLog(@"点击事件");
    
}


/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    
    NSLog(@"群发");
//    //根据storyboard id来获取目标页面
//    GroupSendViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"GroupSendViewController"];
//    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
//    nextPage.hidesBottomBarWhenPushed=YES;
//    //跳转
//    [self.navigationController pushViewController:nextPage animated:YES];
    int a=1;
    int b=2;
    
    NSArray *userlist=[NSArray arrayWithObjects:@"1",@"321",nil];
//    userlist addObject :1
//    [self createDiscussion:@"班级讨论组" userIdList:userlist success:nil error:nil];
    
//    [[RCIM sharedRCIM] createDiscussion:]
    
    [[RCIMClient sharedRCIMClient] createDiscussion:@"班级讨论组" userIdList:userlist success:nil error:nil];
    
}
//- (void)createDiscussion:(NSString *)name
//              userIdList:(NSArray *)userIdList
//                 success:(void (^)(RCDiscussion *discussion))successBlock
//                   error:(void (^)(RCErrorCode status))errorBlock{
////    NSLog(@)
//    
//    
//}
@end
