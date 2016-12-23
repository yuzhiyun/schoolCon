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
    
    NSMutableArray *dataInOnerow;
     NSMutableArray *dataInOnerow2;
    NSMutableArray *allData;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    allData=[[NSMutableArray alloc]init];
    
    dataInOnerow=[[NSMutableArray alloc]init];
    [dataInOnerow addObject:@"数学"];
    [dataInOnerow addObject:@"98"];
    [dataInOnerow addObject:@"02"];
    
    dataInOnerow2=[[NSMutableArray alloc]init];
    [dataInOnerow2 addObject:@"英语"];
    [dataInOnerow2 addObject:@"80"];
    [dataInOnerow2 addObject:@"35"];
    
    [allData addObject:dataInOnerow];
    [allData addObject:dataInOnerow2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [allData count]+1;
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
    //第一行显示文字，不显示具体的数据
   
    UILabel *mUILabelsubject=(UILabel *)[cell viewWithTag:1];
    UILabel *mUILabelScore=(UILabel *)[cell viewWithTag:2];
    UILabel *mUILabelRank=(UILabel *)[cell viewWithTag:3];
    
    if(0==indexPath.row){
        mUILabelsubject.text=@"学科";
         mUILabelScore.text=@"成绩";
         mUILabelRank.text=@"排名";
        
        mUILabelsubject.font=[UIFont systemFontOfSize:20];
        [mUILabelsubject setTextColor:[UIColor blackColor]];
        
        mUILabelScore.font=[UIFont systemFontOfSize:20];
        [mUILabelScore setTextColor:[UIColor blackColor]];

        mUILabelRank.font=[UIFont systemFontOfSize:20];
        [mUILabelRank setTextColor:[UIColor blackColor]];


    }else{
        mUILabelsubject.text=[[allData objectAtIndex:indexPath.row-1] objectAtIndex:0];
        mUILabelScore.text=[[allData objectAtIndex:indexPath.row-1] objectAtIndex:1];
    mUILabelRank.text=[[allData objectAtIndex:indexPath.row-1] objectAtIndex:2];
    }
    
    
    return cell;
}


@end
