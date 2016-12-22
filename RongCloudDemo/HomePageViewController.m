//
//  HomePageViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/15.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "HomePageViewController.h"
#import "NotificationTableViewController.h"
#import "DetailNotificationViewController.h"
#import "PsychologyListTableViewController.h"
#import "QueryGradeTableViewController.h"
//#import "DetailNotificationViewController.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController{

    NSMutableArray *recipes;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    recipes=[[NSMutableArray alloc]init];
    [recipes addObject:@"通知1：由于下大雪，今晚不用上课"];
    [recipes addObject:@"通知2：由于下大雪，今晚不用上课"];
    [recipes addObject:@"通知3：由于下大雪，今晚不用上课"];
//    recipes = [NSArray arrayWithObjects:@"Egg Benedict",@"Ham and Cheese Panini","yuzhiyun",nil];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//跳转到所有通知页面
- (IBAction)btnEnterAllNotifications:(id)sender {
    //根据storyboard id来获取目标页面
    NotificationTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationTableViewController"];
    
    
//    传值
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
        [self.navigationController pushViewController:nextPage animated:YES];
}
//跳转到心理测评
- (IBAction)btnEnterPsychology:(id)sender {
    //根据storyboard id来获取目标页面
    PsychologyListTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"PsychologyListTableViewController"];
    
    
 
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
    
    

}
- (IBAction)enterQueryGrade:(id)sender {
    //根据storyboard id来获取目标页面
    QueryGradeTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"QueryGradeTableViewController"];
    
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //根据storyboard id来获取目标页面
    DetailNotificationViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationViewController"];
    
    
    //    传值
    nextPage->pubString=[recipes objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
    
    
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    
//    [[segue destinationViewController] setMDetailString: @"传值过去"];
//    
//    NSLog(@"能跳转吗？prepareForSegue");
//    
//    
//    
//    
//    
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
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
