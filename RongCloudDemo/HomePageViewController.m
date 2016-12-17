//
//  HomePageViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/15.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "HomePageViewController.h"
#import "NotificationTableViewController.h"
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
