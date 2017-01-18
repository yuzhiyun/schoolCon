//
//  TestResultViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/18.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "TestResultViewController.h"
#import "WMPageController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Article.h"
#import "JsonUtil.h"
#import "MJRefresh.h"
#import "Alert.h"

@interface TestResultViewController ()

@end

@implementation TestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 加载文章列表
-(void)loadData {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/psy/test/getResult",myDelegate.ipString];

    
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"id":testId,
                                  @"score":score
                                  };
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            if([[doc objectForKey:@"code"] isKindOfClass:[NSNumber class]])
                NSLog(@"code 是 NSNumber");
            //判断code 是不是0
            NSNumber *zero=[NSNumber numberWithInt:(0)];
            NSNumber *code=[doc objectForKey:@"code"];
            if([zero isEqualToNumber:code])
            {
                if(nil!=[doc allKeys]){
                    
                    NSArray *articleArray=[doc objectForKey:@"data"];
                    if(0==[articleArray count]){
                        
                          [Alert showMessageAlert:@"亲，没有更多数据了" view:self];
                        
                    }
                    else{
                        
//                        for(NSDictionary *item in  articleArray ){
//                            Article *model=[[Article alloc]init];
//                            model.articleId=item [@"id"];
//                            model.picUrl=item [@"picurl"];
//                            model.title=item [@"title"];
//                            model.author=item [@"author"];
//                            
//                            //                    注意，publishat是NSNumber 类型的，所以不要用字符串去接收，否则报错
//                            //                    -[__NSCFNumber rangeOfCharacterFromSet:]: unrecognized selector sent to instance 0x7fa5216589d0"，对于IOS开发感兴趣的同学可以参考一下： 这个算是类型的不匹配，就是把NSNumber类型的赋给字符串了自己还不知情，
//                            
//                            model.date=item [@"publishat"];
//                            
//                            
//                            NSLog(@"******打印文章列表**********");
//                            NSLog(@"文章articleId是%@",model.articleId);
//                            NSLog(@"文章picUrl是%@",model.picUrl);
//                            NSLog(@"文章title是%@",model.title);
//                            NSLog(@"文章author是%@",model.author);
//                            NSLog(@"文章publishat是%i",model.date);
//                            //添加到数组以便显示到tableview
//                            NSLog(@"addObject之前");
//                            if([orientation isEqualToString:@"up"])
//                                [allDataFromServer addObject:model];
//                            else
//                                [allDataFromServer insertObject:model atIndex:0];
//                            NSLog(@"addObject之后");
//                        }
//                        NSLog(@"mDataArticle项数为%i",[allDataFromServer count]);
                        NSLog(@"//更新界面");
                        //更新界面
//                        [mTableView reloadData];
                    }
                }
                else
                    [Alert showMessageAlert:@"抱歉，尚无文章可以阅读" view:self];
            }
            else
                [Alert showMessageAlert:[doc objectForKey:@"msg"] view:self];
        }
        else
            NSLog(@"*****doc空***********");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.tableView footerEndRefreshing];
//        [self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        
        [Alert showMessageAlert:errorUser view:self];
    }];}


@end
