//
//  OnlineReadingViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "OnlineReadingViewController.h"
#import "ArticleDetailViewController.h"
#import "Vp1TableViewController.h"
#import "AppDelegate.h"
@interface OnlineReadingViewController ()

@end

@implementation OnlineReadingViewController

#pragma mark 初始化代码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    NSMutableArray *title=[[NSMutableArray alloc]init];
     [title addObject:@"读文说史"];
    [title addObject:@"教育智慧"];
    [title addObject:@"人生感悟"];
//    [title addObject:@"分类4"];
//    [title addObject:@"分类5"];

    if(self) {
        self.menuHeight = 35;
        self.menuItemWidth = 100;
        self.menuViewStyle = WMMenuViewStyleLine;
//        self.titles = [NSArray arrayWithObjects:@"读文说史", @"教育智慧",@"分类3",@"分类4",@"分类5", nil];
        self.titles=title;
        self.titleColorSelected = [UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0];
    }
    /*
     *传值,全局变量，但是其实根本不需要传，子页面无需知道自己页面的title，只要知道自己的index　就可以了
     */
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    myDelegate.onlineReadinngTitle=title;

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"在线学习";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];

    // Do any additional setup after loading the view, typically from a nib.
//    //返回按钮的文字设置为 返回，否则默认会显示上一个页面的title
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = item;
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
    UIViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"vp1"]; //这里的identifer是我们之前设置的StoryboardID
    

    
    return controller1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
