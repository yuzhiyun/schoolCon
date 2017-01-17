//
//  VipViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "VipViewController.h"

@interface VipViewController ()

@end

@implementation VipViewController{
    NSMutableArray  *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    data=[[NSMutableArray alloc]init];
    [data addObject:@"一个学期¥60"];
    [data addObject:@"一个学年¥120"];
    [data addObject:@"自定义时间"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *mUILabel=(UILabel*)[cell viewWithTag:1];
    mUILabel.text=[data objectAtIndex:indexPath.row];
//    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
//    cell.detailTextLabel.text=@"2017/12/21";
//    //    cell.tes
//    
//    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    
    return cell;
}

@end
