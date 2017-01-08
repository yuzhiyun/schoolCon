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
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        [xArray addObject:@"高一期末考试"];
        [yArray addObject:[NSString stringWithFormat:@"%.2lf",50.0+arc4random_uniform(50)]];
    }
    
    WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 500) xTitleArray:xArray yValueArray:yArray yMax:100 yMin:0];
    [self.view addSubview:wsLine];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
