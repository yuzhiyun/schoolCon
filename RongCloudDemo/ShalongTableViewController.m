//
//  ShalongTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ShalongTableViewController.h"
#import "ShalongTableViewCell.h"
#import "DetailYuluViewController.h"
 #import "UIImageView+WebCache.h"
@interface ShalongTableViewController ()

@end

@implementation ShalongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"岳麓沙龙";
    
    
    
    
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];

    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    //防止与顶部重叠
    self.tableView.contentInset=UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    //指定大标题
    mData=[[NSMutableArray alloc]init];
    [mData addObject:@"长沙第一次岳麓活动"];
    [mData addObject:@"亲子军营模拟活动"];
    [mData addObject:@"第一届读书交流会"];
    [mData addObject:@"第五届高校马拉松比赛"];
    [mData addObject:@"2016年度百里毅行活动"];
    //指定封面
    mImg=[[NSMutableArray alloc]init];
    [mImg addObject:@"a1.png"];
    [mImg addObject:@"a2.jpg"];
    [mImg addObject:@"a3.jpg"];
    [mImg addObject:@"a4.jpg"];
    [mImg addObject:@"a5.jpg"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [mData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShalongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        
        cell=[[ShalongTableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    NSString *t1=[mData objectAtIndex:indexPath.row];
    
//    cell.UILabelTitle.text=t1;
    cell.UILabelTitle.text=[mData objectAtIndex:indexPath.row];
    cell.UILabelDate.text=@"2016-12-27";
    cell.UIImgCover.image=[UIImage imageNamed:[mImg objectAtIndex:indexPath.row]];
    //
    //    加载图片,如果加载不到图片，就显示favorites.png
//    [cell.UIImgCover sd_setImageWithURL:[mImg objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"favorites.png"]];
//
//    // Configure the cell...
//    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据storyboard id来获取目标页面
    DetailYuluViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailYuluViewController"];
    //    传值
    nextPage->pubString=[mData objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}


@end
