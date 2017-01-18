//
//  EducationViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/6.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "EducationViewController.h"
#import "ArticleTableViewController.h"

#import "ShalongTableViewController.h"
#import "AppDelegate.h"
@interface EducationViewController ()

@end

@implementation EducationViewController


#pragma mark 初始化代码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    NSMutableArray *title=[[NSMutableArray alloc]init];
    [title addObject:@"岳麓沙龙"];
    [title addObject:@"在线学习"];
    // [title addObject:@"活动"];
    //    [title addObject:@"分类4"];
    //    [title addObject:@"分类5"];
//    typedef NS_ENUM(NSUInteger, WMMenuViewStyle) {
//        WMMenuViewStyleDefault,     // 默认
//        WMMenuViewStyleLine,        // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
//        WMMenuViewStyleFlood,       // 涌入效果 (填充)
//        WMMenuViewStyleFloodHollow, // 涌入效果 (空心的)
//    };
    if(self) {
        self.menuHeight = 35;
        self.menuItemWidth = 75;
        self.menuViewStyle = WMMenuViewStyleLine;
        //        self.titles = [NSArray arrayWithObjects:@"读文说史", @"教育智慧",@"分类3",@"分类4",@"分类5", nil];
        self.titles=title;
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
    self.title=@"教育天地";
    //   navigationBar背景
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [self.navigationController.navigationBar setBarTintColor:myDelegate.navigationBarColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    //    返回箭头和文字的颜色，只要写一次就行了，是全局的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.titles objectAtIndex:index];
}

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self.titles count];
}

#pragma mark 返回某个index对应的页面，该页面从Storyboard中获取
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ShalongTableViewController *controller0 = (ShalongTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ShalongTableViewController"];
    //标识这是岳麓沙龙，用于复用界面
    controller0->type=@"ylsl";
    ArticleTableViewController *controller1 = (ArticleTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ArticleTableViewController"];
    //标示这是在线学习，用于复用界面
    controller1->type=@"zxxx";
    if(index==0)
        return controller0;
    else
        return controller1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

