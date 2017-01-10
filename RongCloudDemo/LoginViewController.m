//
//  LoginViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/24.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "MainViewController.h"
#import "ChooseSchoolTableViewController.h"
#import "ForgetPwdViewController.h"
#import "AFNetworking.h"

#define JsonGet @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
//    头像圆形
    self.UIImageViewAvatar.layer.masksToBounds = YES;
    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
    
//    隐藏返回按钮navigationController的navigationBar
//    self.navigationController.navigationBarHidden=YES;
    
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)login:(id)sender {
    MainViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}


- (IBAction)forgetPwd:(id)sender {
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    nextPage->index=3;
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)active:(id)sender {
    ChooseSchoolTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseSchoolTableViewController"];
    nextPage->index=2;
    [self.navigationController pushViewController:nextPage animated:YES];
}


#pragma mark 请求数据
-(void)loadData{
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    /*
     第一个参数：请求的地址
     第二个参数：需要传给服务端的参数
     第三个参数：数据请求成功回调的block >>>成功后的数据：responseObject
     第四个参数：数据请求失败回调的block >>>失败后的原因：error
     */
    [manager GET:JsonGet parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *applications=dic[@"applications"];
        
        for (NSDictionary *item in applications) {
//            JsonGetModel *model=[[JsonGetModel alloc]init];
//            model.iconUrl = item[@"iconUrl"];
//            model.name = item[@"name"];
//            model.description1 = item[@"description"];
//            model.updateDate = item[@"updateDate"];
//            [_dataArray addObject:model];
            NSLog(item[@"name"]);
        }
//        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}










@end
