//
//  ContactViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ContactViewController.h"

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
        self.titles = [NSArray arrayWithObjects:@"消息", @"联系人",@"群发", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    UIViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"vp1_contact"]; //这里的identifer是我们之前设置的StoryboardID
    UIViewController *controller2 = [storyboard instantiateViewControllerWithIdentifier:@"vp2_contact"]; //这里的identifer是我们之前设置的StoryboardID
    UIViewController *controller3 = [storyboard instantiateViewControllerWithIdentifier:@"vp3_contact"]; //这里的identifer是我们之前设置的StoryboardID
    
    if(0==index)
        return controller1;
    else if(1==index)
        return controller2;
    else
        return controller3;
    
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
