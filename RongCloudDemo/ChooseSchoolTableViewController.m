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
    
    
    //    显示返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=NO;
    
    mDataNotification=[[NSMutableArray alloc]init];
    [mDataNotification addObject:@"中南大学"];
    [mDataNotification addObject:@"长沙理工大学"];
    [mDataNotification addObject:@"湖南女子学院"];
    [mDataNotification addObject:@"长沙大学"];
    [mDataNotification addObject:@"湖南大学"];
    [mDataNotification addObject:@"武汉大学"];
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
    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
    cell.detailTextLabel.text=@"2017/12/21";
    return cell;
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据storyboard id来获取目标页面
    LoginViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    NSLog(@"跳转");
}

@end
