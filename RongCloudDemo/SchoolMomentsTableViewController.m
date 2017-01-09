//
//  SchoolMomentsTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/9.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "SchoolMomentsTableViewController.h"
#import "DetailNotificationViewController.h"
@interface SchoolMomentsTableViewController ()

@end

@implementation SchoolMomentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    //    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
    
    
    UIImageView *mUIImageViewCover=(UIImageView *)[cell viewWithTag:1];
    mUIImageViewCover.image=[UIImage imageNamed:@"3.jpg"];
    UILabel *mUILabelTitle=(UILabel *)[cell viewWithTag:2];
    mUILabelTitle.text=@"恭喜我校获得省优秀校园称号";
    
    UILabel *mUILabelDate=(UILabel *)[cell viewWithTag:3];
    mUILabelDate.text=@"2017-01-02";
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNotificationViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationViewController"];
//    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
