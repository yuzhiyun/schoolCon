//
//  ChooseSchoolTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/25.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ChooseSchoolTableViewController.h"
#import "LoginViewController.h"
@interface ChooseSchoolTableViewController ()

@end

@implementation ChooseSchoolTableViewController{
    
    NSMutableArray *mDataNotification;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择学校";
    //    navigationBar背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
    //      navigationBar标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
//    返回箭头和文字的颜色，只要写一次就行了，是全局的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    //    显示返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=NO;
    
    mDataNotification=[[NSMutableArray alloc]init];
    [mDataNotification addObject:@"长郡中学"];
    [mDataNotification addObject:@"长沙第一中学"];
    [mDataNotification addObject:@"长沙师大附中"];
    [mDataNotification addObject:@"铁道小学"];
    [mDataNotification addObject:@"湖南第一中学"];
    [mDataNotification addObject:@"长沙市第一中学"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mDataNotification count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [mDataNotification objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"school.png"];
    cell.detailTextLabel.text=nil;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据storyboard id来获取目标页面
    LoginViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}

@end
