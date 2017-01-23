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
#import "LinkMan.h"
#import "UIImageView+WebCache.h"
#import "SendMessageViewController.h"
@interface GroupSendViewController ()

@end

@implementation GroupSendViewController{
    
    NSMutableArray *allDataFromServer;
    //被勾选的用户
    NSMutableArray *indexOfSelectedUser;
    //用于刷新tableView
    UITableView *mTableView;
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"群发";
    
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //    mDataUsername=[[NSMutableArray alloc]init];
    //    [mDataUsername addObject:@"俞志云"];
    //    [mDataUsername addObject:@"马小龙"];
    //    [mDataUsername addObject:@"孙萌"];
    //    [mDataUsername addObject:@"吴晓茎"];
    //    [mDataUsername addObject:@"秦启飞"];
    //
    //    mDataRemark=[[NSMutableArray alloc]init];
    //    [mDataRemark addObject:@"化学教师"];
    //    [mDataRemark addObject:@"数学教师"];
    //    [mDataRemark addObject:@"英语教师"];
    //    [mDataRemark addObject:@"语文教师"];
    //    [mDataRemark addObject:@"生物教师"];
    //
    //    mDataAvatar=[[NSMutableArray alloc]init];
    //    [mDataAvatar addObject:@"1.jpg"];
    //    [mDataAvatar addObject:@"2.jpg"];
    //    [mDataAvatar addObject:@"3.jpg"];
    //    [mDataAvatar addObject:@"4.jpg"];
    //    [mDataAvatar addObject:@"5.jpg"];
    LinkMan *model1=[[LinkMan alloc]init];
    model1.type=@"private";
    model1.LinkmanId=@"321";
    model1.picUrl=@"http://avatar.csdn.net/B/A/4/1_yuzhiyun3536.jpg";
    model1.name=@"俞志云";
    model1.introduction=@"化学教师";
    
    
    LinkMan *model2=[[LinkMan alloc]init];
    model2.type=@"private";
    model2.LinkmanId=@"2";
    model2.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    model2.name=@"马小龙";
    model2.introduction=@"数学教师";
    
    LinkMan *model3=[[LinkMan alloc]init];
    model3.type=@"private";
    model3.LinkmanId=@"3";
    model3.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    model3.name=@"孙秦晓茎";
    model3.introduction=@"语文教师";
    
    allDataFromServer=[[NSMutableArray alloc]init];
    [allDataFromServer addObject:model1];
    [allDataFromServer addObject:model2];
    [allDataFromServer addObject:model3];
    
    //没有被初始化，导致了一些未知错误，但是这个变量 竟然可以使用，程序不崩溃
    indexOfSelectedUser=[[NSMutableArray alloc]init];
    //初始化勾选记录的数组,用yes或者 no来判断联系人是不是被勾选
    for(NSInteger i=0;i<[allDataFromServer count];i++){
        [indexOfSelectedUser addObject:@"no"];
        NSString *content=[indexOfSelectedUser objectAtIndex:i];
    }
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
    
    mTableView=tableView;
    return [allDataFromServer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    GroupSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[GroupSendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
    
    cell.UILabelName.text = model.name;
    cell.UILabelRemark.text = model.introduction;
    cell.UIImgAvatar.layer.masksToBounds = YES;
    cell.UIImgAvatar.layer.cornerRadius = cell.UIImgAvatar.frame.size.height / 2 ;
    [cell.UIImgAvatar sd_setImageWithURL:model.picUrl placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    
    
    NSString *index=[indexOfSelectedUser objectAtIndex:indexPath.row];
    
    if(![ index isEqualToString:@"no"]){
        
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"selected2.png"];
    }
    else
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"un_selected.png"];
    return cell;
}

//把checkbox的图标改成被选中的
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[indexOfSelectedUser objectAtIndex:indexPath.row]isEqualToString:@"no"]){
        
        [indexOfSelectedUser insertObject:@"yes" atIndex:indexPath.row];
        [indexOfSelectedUser removeObjectAtIndex: indexPath.row+1];
    }
    else
    {  [indexOfSelectedUser insertObject:@"no" atIndex:indexPath.row];
        [indexOfSelectedUser removeObjectAtIndex: indexPath.row+1];
        
    }
    
    [mTableView reloadData];
    NSLog(@"点击事件");
    
}


/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    NSLog(@"勾选的群发联系人群发");
    for(NSString *content in indexOfSelectedUser)
        NSLog(content);
    NSMutableArray *dataSelectedLinkman=[[NSMutableArray alloc]init];
    
    for(NSInteger i=0;i<[allDataFromServer count];i++)
        if([@"yes" isEqualToString: [indexOfSelectedUser objectAtIndex:i]])
            [ dataSelectedLinkman addObject:[allDataFromServer objectAtIndex:i]];
//    
//    
//    
//    
//    for(LinkMan *model in dataSelectedLinkman){
//        NSLog(model.LinkmanId);
//        NSLog(model.name);
//    }
    
    if([dataSelectedLinkman count]>0){
        SendMessageViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"SendMessageViewController"];
        nextPage->dataSelectedLinkman=dataSelectedLinkman;
        nextPage.hidesBottomBarWhenPushed=YES;
        //跳转
        [self.navigationController pushViewController:nextPage animated:YES];
    }else{
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:nil
                                   message:@"尚未勾选联系人"
                                  delegate:nil
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:nil];
            [alert show];
    }
    //    //根据storyboard id来获取目标页面
    //    GroupSendViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"GroupSendViewController"];
    //    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    //    nextPage.hidesBottomBarWhenPushed=YES;
    //    //跳转
    //    [self.navigationController pushViewController:nextPage animated:YES];
    //    int a=1;
    //    int b=2;
    
    //    NSArray *userlist=[NSArray arrayWithObjects:@"1",@"321",nil];
    //    userlist addObject :1
    //    [self createDiscussion:@"班级讨论组" userIdList:userlist success:nil error:nil];
    
    //    [[RCIM sharedRCIM] createDiscussion:]
    
    //    [[RCIMClient sharedRCIMClient] createDiscussion:@"班级讨论组" userIdList:userlist success:nil error:nil];

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
