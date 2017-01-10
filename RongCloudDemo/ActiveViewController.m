//
//  ActiveViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//
#import "ActiveViewController.h"
#import "MainViewController.h"
#import "SetPwdAfterActiveViewController.h"
#import "AFNetworking.h"

#define JsonGet @"http://192.168.0.108:8080/schoolCon/api/cms/article/getObject post id 6699179dd1de4320b97be3359818f541"
@interface ActiveViewController ()

@end

@implementation ActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"激活";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
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



- (IBAction)active:(id)sender {
    
    SetPwdAfterActiveViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"SetPwdAfterActiveViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
    
}

- (IBAction)getCode:(id)sender {
    
    
}


@end
