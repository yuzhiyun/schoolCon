//
//  QueryGradeTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "QueryGradeTableViewController.h"
#import "TeacherViewController.h"
#import "OptionViewController.h"
#import "TeacherNotUseCollectionViewController.h"
@interface QueryGradeTableViewController ()

@end

@implementation QueryGradeTableViewController{
    
    NSMutableArray *mDataNotification;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=@"请勾选测试类别";
    mDataNotification=[[NSMutableArray alloc]init];
    
  
    [mDataNotification addObject:@"高一第一次月考"];
    [mDataNotification addObject:@"高一第二次考试"];
    [mDataNotification addObject:@"第三次全市联考"];
//    [mDataNotification addObject:@"第五次模拟考"];
    [mDataNotification addObject:@"高一期中考试"];
    [mDataNotification addObject:@"高一期末考试"];

    //    recipes = [NSArray arrayWithObjects:@"Egg Benedict",@"Ham and Cheese Panini","yuzhiyun",nil];
    // Do any additional setup after loading the view.
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
    return [mDataNotification count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    cell.imageView.image=[UIImage imageNamed:@"exam1.png"];
    cell.detailTextLabel.text=@"2017/12/21";

    cell.textLabel.text = [mDataNotification objectAtIndex:indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //根据storyboard id来获取目标页面
    TeacherNotUseCollectionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherNotUseCollectionViewController"];
    
    
    //    传值
//    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
    
    
    
}

@end
