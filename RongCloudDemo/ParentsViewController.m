//
//  ParentsViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/6.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ParentsViewController.h"
#import "WSLineChartView.h"
@interface ParentsViewController ()

@end

@implementation ParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        [xArray addObject:@"高一期末考试"];
        [yArray addObject:[NSString stringWithFormat:@"%.2lf",50.0+arc4random_uniform(50)]];
    }
    
    WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.bounds.size.height-[[UIApplication sharedApplication] statusBarFrame].size.height) xTitleArray:xArray yValueArray:yArray yMax:100 yMin:0];
    
    
    [self.view addSubview:wsLine];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
