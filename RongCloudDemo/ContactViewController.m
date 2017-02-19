//
//  ContactViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ContactViewController.h"
#import "GroupSendViewController.h"
#import "AppDelegate.h"
#import "Alert.h"
#import "AFNetworking.h"
#import "JsonUtil.h"
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
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"群发" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    
    [rightButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    //   navigationBar背景
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [self.navigationController.navigationBar setBarTintColor:myDelegate.navigationBarColor];
    //title颜色
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

/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    
    if([AppDelegate isTeacher]){
        
        //根据storyboard id来获取目标页面
        GroupSendViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"GroupSendViewController"];
        //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
        nextPage.hidesBottomBarWhenPushed=YES;
        //跳转
        [self.navigationController pushViewController:nextPage animated:YES];
        return;
    }
    
    if(0==[myDelegate.linkManArray count]){
        [Alert showMessageAlert:@"尚无联系人信息，请先在联系人页面下拉刷新，然后再次点击群发" view:self];
    }
    else{
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        NSString *urlString= [NSString stringWithFormat:@"%@/api/sys/user/validateVip",myDelegate.ipString];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
        NSString *token=myDelegate.token;
        // 请求参数
        NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                      @"appSecret":@"b4a01f5a7dd4416c",
                                      @"token":token
                                      };
        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            
            NSString *result=[JsonUtil DataTOjsonString:responseObject];
            NSLog(@"***************返回结果***********************");
            NSLog(result);
            NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error=[[NSError alloc]init];
            NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if(doc!=nil){
                NSLog(@"*****doc不为空***********");
                //判断code 是不是0
                NSNumber *zero=[NSNumber numberWithInt:(0)];
                NSNumber *code=[doc objectForKey:@"code"];
                if([zero isEqualToNumber:code])
                {
                    //根据storyboard id来获取目标页面
                    GroupSendViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"GroupSendViewController"];
                    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
                    nextPage.hidesBottomBarWhenPushed=YES;
                    //跳转
                    [self.navigationController pushViewController:nextPage animated:YES];
                }
                else{
                    if([@"token invalid" isEqualToString:[doc objectForKey:@"msg"]]){
                        [AppDelegate reLogin:self];
                    }
                    else{
                        NSString *msg=[NSString stringWithFormat:@"code是%d ： %@",[doc objectForKey:@"code"],[doc objectForKey:@"msg"]];
                        NSNumber *zero=[NSNumber numberWithInt:(0)];
                        if([[NSNumber numberWithInt:(-2)] isEqualToNumber:[doc objectForKey:@"code"]]){
                            [Alert showMessageAlert:@"抱歉，您不是会员或会员已到期，无法进行此操作，请在“我的会员”页面中进行充值"  view:self];
                        }
                    }
                }
            }
            else
                NSLog(@"*****doc空***********");
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
            if(-1009==error.code||-1016==error.code)
                errorUser=@"主人，似乎没有网络喔！";
            [Alert showMessageAlert:errorUser view:self];
        }];
    }
}


#pragma mark 返回某个index对应的页面，该页面从Storyboard中获取
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"vp1_contact"]; //这里的identifer是我们之前设置的StoryboardID
    UIViewController *controller2 = [storyboard instantiateViewControllerWithIdentifier:@"vp2_contact"]; //这里的identifer是我们之前设置的StoryboardID
//    UIViewController *controller3 = [storyboard instantiateViewControllerWithIdentifier:@"vp3_contact"]; //这里的identifer是我们之前设置的StoryboardID
    
    if(0==index)
        return controller1;
    else
        return controller2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
