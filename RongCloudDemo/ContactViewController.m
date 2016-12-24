//
//  ContactViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ContactViewController.h"
#import "GroupSendViewController.h"
@interface ContactViewController ()

@end

@implementation ContactViewController

#pragma mark 初始化代码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.menuHeight = 35;
        self.menuItemWidth = 100;
        self.menuViewStyle = WMMenuViewStyleLine;
//        self.titles = [NSArray arrayWithObjects:@"消息", @"联系人",@"群发", nil];
        self.titles = [NSArray arrayWithObjects:@"消息", @"联系人",nil];
        //修改WMPageController 的title颜色为蓝色
        self.titleColorSelected = [UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0];

    }
    
    
   
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"群聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    
    [rightButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
    //title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
//    返回按钮文字、颜色 、大小
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [item setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = item;
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.titles objectAtIndex:index];
}

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self.titles count];
}

/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    //根据storyboard id来获取目标页面
    GroupSendViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"GroupSendViewController"];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}

#pragma mark 返回某个index对应的页面，该页面从Storyboard中获取
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"vp1_contact"]; //这里的identifer是我们之前设置的StoryboardID
    UIViewController *controller2 = [storyboard instantiateViewControllerWithIdentifier:@"vp2_contact"]; //这里的identifer是我们之前设置的StoryboardID
//    UIViewController *controller3 = [storyboard instantiateViewControllerWithIdentifier:@"vp3_contact"]; //这里的identifer是我们之前设置的StoryboardID
    
    if(0==index)
        return controller1;
//    else if(1==index)
//        return controller2;
    else
        return controller2;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
