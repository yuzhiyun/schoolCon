//
//  OnlineReadingViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "OnlineReadingViewController.h"
#import "ArticleDetailViewController.h"
@interface OnlineReadingViewController ()

@end

@implementation OnlineReadingViewController

#pragma mark 初始化代码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.menuHeight = 35;
        self.menuItemWidth = 100;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titles = [NSArray arrayWithObjects:@"读文说史", @"教育智慧", nil];
        self.titleColorSelected = [UIColor colorWithRed:0 green:0 blue:200 alpha:1];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
    UIViewController *controlle2 = [storyboard instantiateViewControllerWithIdentifier:@"vp2"]; //这里的identifer是我们之前设置的StoryboardID
    
    if(index==1)
        
        return controller1;
    else
        return controlle2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
//- (IBAction)btnEnterArticleDetail:(id)sender {
//
//
//    //根据storyboard id来获取目标页面
//    ArticleDetailViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
//
//
//    //    传值
//    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
//    nextPage.hidesBottomBarWhenPushed=YES;
//
//    //跳转
//    [self.navigationController pushViewController:nextPage animated:YES];
//
//
//
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


