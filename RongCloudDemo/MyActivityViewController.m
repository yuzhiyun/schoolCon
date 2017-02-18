//
//  MyActivityViewController.m
//  SchoolCon
//
//  Created by 秦启飞 on 2017/2/11.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "MyActivityViewController.h"
#import "ShalongTableViewController.h"
@interface MyActivityViewController ()

@end
@implementation MyActivityViewController

#pragma mark 初始化代码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.menuHeight = 35;
        self.menuItemWidth = 100;
        self.menuViewStyle = WMMenuViewStyleLine;
        //        self.titles = [NSArray arrayWithObjects:@"消息", @"联系人",@"群发", nil];
        self.titles = [NSArray arrayWithObjects:@"岳麓沙龙", @"心理活动",nil];
        //修改WMPageController 的title颜色为蓝色
        self.titleColorSelected = [UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0];
        
        //被选中字体和未被选中大小一样
        self.titleSizeSelected=self.titleSizeNormal;
        //未被选中时候文字颜色
        self.titleColorNormal=[UIColor lightGrayColor];
        //设置menu 背景色
        self.menuBGColor=[UIColor whiteColor];
        
    }
    
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回某个index对应的页面，该页面从Storyboard中获取
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ShalongTableViewController  *controller = [storyboard instantiateViewControllerWithIdentifier:@"ShalongTableViewController"];
    
    if(0==index){
        controller->type=@"jiaoyu";
    }else if(1==index)
        controller->type=@"xinli";
        return controller;
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.titles objectAtIndex:index];
}

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self.titles count];
}

@end
