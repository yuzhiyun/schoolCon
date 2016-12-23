//
//  TeacherNotUseCollectionViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/23.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "TeacherNotUseCollectionViewController.h"

@interface TeacherNotUseCollectionViewController ()

@end

@implementation TeacherNotUseCollectionViewController{
    
    NSMutableArray *recipes;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    recipes=[[NSMutableArray alloc]init];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    //    recipes = [NSArray arrayWithObjects:@"Egg Benedict",@"Ham and Cheese Panini","yuzhiyun",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    //    }
    if (cell == nil) {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
//    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
//    cell.detailTextLabel.text=@"2017/12/21";
//    //    cell.tes
//    
//    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    
    UILabel *mUILabelsubject=(UILabel *)[cell viewWithTag:1];
    mUILabelsubject.text=@"学科";

    
    UILabel *mUILabelsubject2=(UILabel *)[cell viewWithTag:2];
    mUILabelsubject.text=@"成绩";

    return cell;
}


@end
