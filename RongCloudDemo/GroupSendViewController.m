//
//  GroupSendViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "GroupSendViewController.h"
#import "GroupSendTableViewCell.h"
@interface GroupSendViewController ()

@end

@implementation GroupSendViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataRemark;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mDataUsername=[[NSMutableArray alloc]init];
    [mDataUsername addObject:@"俞志云"];
    [mDataUsername addObject:@"马小龙"];
    [mDataUsername addObject:@"孙萌"];
    [mDataUsername addObject:@"吴晓茎"];
    [mDataUsername addObject:@"秦启飞"];
    
    mDataRemark=[[NSMutableArray alloc]init];
    [mDataRemark addObject:@"小鱼的爸爸"];
    [mDataRemark addObject:@"小龙的爸爸"];
    [mDataRemark addObject:@"小萌的妈妈"];
    [mDataRemark addObject:@"晓茎的爸爸"];
    [mDataRemark addObject:@"小飞的爸爸"];
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

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [mDataUsername count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    GroupSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[GroupSendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.UILabelName.text = [mDataUsername objectAtIndex:indexPath.row];
    cell.UILabelRemark.text = [mDataRemark objectAtIndex:indexPath.row];
    cell.UIImgAvatar.image=[UIImage imageNamed:@"avarta.jpg"];
    
//    cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"selected2.png"];

    return cell;
}

//把checkbox的图标改成被选中的
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GroupSendTableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //    cell.UIButtonCheckbox.
    cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"1.jpg"];
    NSLog(@"点击事件");
    
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
