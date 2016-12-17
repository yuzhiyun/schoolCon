//
//  Vp1TableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "Vp1TableViewController.h"
#import "Vp1TableViewCell.h"
#import "ArticleDetailViewController.h"
@interface Vp1TableViewController ()

@end

@implementation Vp1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //防止与顶部重叠
    self.tableView.contentInset=UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    //指定大标题
    mData=[[NSMutableArray alloc]init];
    [mData addObject:@"你微笑过的地方"];
    [mData addObject:@"便是最美的风景"];
    [mData addObject:@"唯我独不敬亭"];
    [mData addObject:@"嗨，你还在那里吗"];
    [mData addObject:@"愿风带着我的思念来到你的窗前"];
    //指定封面
    mImg=[[NSMutableArray alloc]init];
    [mImg addObject:@"1.jpg"];
    [mImg addObject:@"2.jpg"];
    [mImg addObject:@"3.jpg"];
    [mImg addObject:@"4.jpg"];
    [mImg addObject:@"5.jpg"];
    
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
    Vp1TableViewCell *cell = (Vp1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        
        cell=[[Vp1TableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    NSString *t1=[mData objectAtIndex:indexPath.row];
    
    cell.UILabelTitle.text=t1;
    cell.UILabelDate.text=@"2016-12-27";
    cell.UIImgCover.image=[UIImage imageNamed:[mImg objectAtIndex:indexPath.row]];
    
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //根据storyboard id来获取目标页面
    ArticleDetailViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
    
    
    //    传值
    nextPage->pubString=[mData objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
    
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
