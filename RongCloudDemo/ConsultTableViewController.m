//
//  ConsultTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ConsultTableViewController.h"
#import "MJRefresh.h"
@interface ConsultTableViewController ()

@end

@implementation ConsultTableViewController{
    NSMutableArray *mDataConsult;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mDataConsult=[[NSMutableArray alloc]init];
    [mDataConsult addObject:@"初始数据"];
    [mDataConsult addObject:@"初始数据"];
    [mDataConsult addObject:@"初始数据"];
    [mDataConsult addObject:@"初始数据"];
    [mDataConsult addObject:@"初始数据"];
    // 2.集成刷新控件
    [self setupRefresh];
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在为您刷新。。。";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在为您刷新。。。";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [mDataConsult insertObject:@"下拉刷新数据" atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [mDataConsult addObject:@"上拉刷新数据"];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    //第一段之显示一条数据
    if(0==section)
        return 1;
    else
    return [mDataConsult count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    //    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
    
    if(1==indexPath.section){
    
    UILabel *mUILabelName=(UILabel *)[cell viewWithTag:1];
    mUILabelName.text=@"张新源";
    UILabel *mUILabelTitle=(UILabel *)[cell viewWithTag:2];
    mUILabelTitle.text=@"一级心理咨询师";
    
    UILabel *mUILabelSpecialty=(UILabel *)[cell viewWithTag:3];
    //mUILabelSpecialty.text=@"认知行为治疗";
    mUILabelSpecialty.text=[mDataConsult objectAtIndex:indexPath.row];
    }
    else{
        
        
        UILabel *mUILabelName=(UILabel *)[cell viewWithTag:1];
        mUILabelName.text=@"电话咨询";
        UILabel *mUILabelTitle=(UILabel *)[cell viewWithTag:2];
        mUILabelTitle.text=@"";
        
        UILabel *mUILabelSpecialty=(UILabel *)[cell viewWithTag:3];
         UILabel *mUILabelSpecialtyLeft=(UILabel *)[cell viewWithTag:4];
        mUILabelSpecialtyLeft.text=@"15111356394";
        //mUILabelSpecialty.text=@"认知行为治疗";
        mUILabelSpecialty.text=@"";
        
        UIImageView *mUIImageView=(UIImageView *)[cell viewWithTag:5];
        mUIImageView.image=[UIImage imageNamed:@"phoneConsult.png"];
    
    }
    return cell;
}


-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if(0==section)
        return @"电话咨询";
    else
        return @"心理咨询师";
}
@end
