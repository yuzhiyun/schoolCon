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
#import "ParentsViewController.h"
@interface QueryGradeTableViewController ()

@end

@implementation QueryGradeTableViewController{
    
    NSMutableArray *mDataExam;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.title=@"选择考试";
    mDataExam=[[NSMutableArray alloc]init];
    
    
    [mDataExam addObject:@"高一第一次月考"];
    [mDataExam addObject:@"高一第二次考试"];
    [mDataExam addObject:@"第三次全市联考"];
    //    [mDataNotification addObject:@"第五次模拟考"];
    [mDataExam addObject:@"高一期中考试"];
    [mDataExam addObject:@"高一期末考试"];
    
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
    //最后一项是查看成绩变化趋势
    return [mDataExam count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    if(indexPath.row!=[mDataExam count]){
        cell.imageView.image=[UIImage imageNamed:@"exam1.png"];
        cell.detailTextLabel.text=@"2017/12/21";
        
        cell.textLabel.text = [mDataExam objectAtIndex:indexPath.row];
    }
    else{
        cell.imageView.image=nil;
        cell.textLabel.text=@"    ————^--查看成绩变化趋势--^————";
        
        cell.detailTextLabel.text =nil;
        
    }
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //根据storyboard id来获取目标页面
    TeacherNotUseCollectionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherNotUseCollectionViewController"];
    
    ParentsViewController *nextPageGradeChange= [self.storyboard instantiateViewControllerWithIdentifier:@"ParentsViewController"];
    

    //    传值
    //    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    nextPageGradeChange.hidesBottomBarWhenPushed=YES;
    
    if(indexPath.row!=[mDataExam count])
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
else
    //跳转
    [self.navigationController pushViewController:nextPageGradeChange animated:YES];

    
    
    
    
}

@end
