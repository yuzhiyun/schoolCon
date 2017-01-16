//
//  ChooseYearViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/15.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ChooseYearViewController.h"
#import "CCZTableButton.h"
@interface ChooseYearViewController ()
@property (nonatomic, strong) CCZTableButton *tableButton;
@end

@implementation ChooseYearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableButton = [[CCZTableButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_mUIButtonSelect.frame), CGRectGetMaxY(_mUIButtonSelect.frame), 100, 0)];
    self.tableButton.offsetXOfArrow = 40;
    self.tableButton.wannaToClickTempToDissmiss = NO;
    [self.tableButton addItems:@[@"Objective-C",@"Swift",@"C++",@"C",@"Python",@"Javascript"]];
    [self.tableButton selectedAtIndexHandle:^(NSUInteger index, NSString *itemName) {
        NSLog(@"%@",itemName);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)select:(id)sender {
    
    [self.tableButton show];
    
}

- (IBAction)query:(id)sender {
    
    
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
