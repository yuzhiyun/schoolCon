//
//  OnlineReadingViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "OnlineReadingViewController.h"
#import "ArticleDetailViewController.h"
#import "ArticleTableViewController.h"
#import "AppDelegate.h"
#import "PsychologyTableViewController.h"
#import "ShalongTableViewController.h"
#import "ConsultTableViewController.h"
@interface OnlineReadingViewController ()

@end

@implementation OnlineReadingViewController

#pragma mark 初始化代码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    NSMutableArray *title=[[NSMutableArray alloc]init];
    [title addObject:@"测试"];
    [title addObject:@"知识"];
    [title addObject:@"活动"];
    [title addObject:@"咨询"];
    
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
    
    
    PsychologyTableViewController *controller0 = (PsychologyTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PsychologyTableViewController"];//这里的identifer是我们之前设置的StoryboardID
    
    ArticleTableViewController *controller1 = (ArticleTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ArticleTableViewController"];
    ShalongTableViewController *controller2 = (ShalongTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ShalongTableViewController"];
    
    
    ConsultTableViewController *controller3 = (ConsultTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ConsultTableViewController"];
    

    //index这个参数需要定义在Vp1TableViewController中，注意写在.h文件中，写在.m文件就访问不到，不知为什么，以后研究吧
    controller1->index=index;
    if(index==0)
        return controller0;
    else if(index==1)
        return controller1;
    else if(index==2)
        return controller2;
    else
        return controller3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
