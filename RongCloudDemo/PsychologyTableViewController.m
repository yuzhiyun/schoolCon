//
//  TemplateTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "PsychologyTableViewController.h"
#import "PsychologyTableViewCell.h"
#import "TestViewController.h"
#import "PhysicalTest.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "TestIntroductionViewController.h"
#import "AppDelegate.h"
#import "WMPageController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Article.h"
#import "JsonUtil.h"
#import "MJRefresh.h"
#import "Test.h"
#import "TestResultViewController.h"
#import "Alert.h"
@interface PsychologyTableViewController ()

@end

@implementation PsychologyTableViewController{
    NSMutableArray *allDataFromServer;
    UITableView *mTableView;
    //页面索引，分页查询数据，下拉刷新的时候需要使用到
    int pageIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=pubString;
    //数据默认为先加载第一页
    pageIndex=1;
    [self loadData:pageIndex orientation:@"up"];
    
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];

    allDataFromServer=[[NSMutableArray alloc]init];
    

    
    // 2.集成刷新控件
    [self setupRefresh];
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在为您刷新。。。";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在为您刷新。。。";
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.tableView.headerRefreshingText = @"正在为您刷新。。。";
    pageIndex++;
    [self loadData:pageIndex orientation:@"down"];
    
}

- (void)footerRereshing
{  self.tableView.footerRefreshingText = @"正在为您刷新。。。";
    
    pageIndex++;
    [self loadData:pageIndex orientation:@"up"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    return [allDataFromServer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PsychologyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        
        cell=[[PsychologyTableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    Test  *model=[allDataFromServer objectAtIndex:indexPath.row];
    
    cell.UILabelTitle.text=model.title;
    NSLog(@"money3");
//    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//    NSString *money = [numberFormatter stringFromNumber:model.money];
    
//    cell.UILabelPrice.text=[NSString stringWithFormat:@"%@",  model.money];
    if ([@"wdcs" isEqualToString:type]) {
        cell.mUILabelPriceKey.text=@"分数";
        cell.mUILabelTestNumKey.text=model.testNumber;
        cell.UILabelNumOfTest.text=@"";
    }
    else
        cell.UILabelNumOfTest.text=model.testNumber;
    
    
    cell.UILabelPrice.text= model.money.stringValue;
    

    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *picUrl=[NSString stringWithFormat:@"%@%@",myDelegate.ipString,model.picUrl];
    
    NSLog(picUrl);
    [cell.UIImageViewCover sd_setImageWithURL: picUrl placeholderImage:[UIImage imageNamed:myDelegate.loadingImg]];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Test *model=[allDataFromServer objectAtIndex:indexPath.row];
    if([@"xlcs" isEqualToString:type]){
    //根据storyboard id来获取目标页面
    TestIntroductionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestIntroductionViewController"];
//     传值
    nextPage->testId=model.testId;
    nextPage->testName=model.title;
    nextPage->picUrl=model.picUrl;
    nextPage->money=model.money;
        
    
//    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    }
    
    else if ([@"wdcs" isEqualToString:type]){
        TestResultViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestResultViewController"];
        nextPage->testId=model.testId;
        nextPage->testName=model.title;
        nextPage->picUrl=model.picUrl;
        
        
        nextPage->score=model.money;
        
        nextPage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    
}
#pragma mark 加载活动列表
-(void)loadData:(int)pageIndex orientation:(NSString *) orientation {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString;
    
        if([@"xlcs" isEqualToString:type])
            urlString= [NSString stringWithFormat:@"%@/api/psy/test/getList",myDelegate.ipString];
    else if ([@"wdcs" isEqualToString:type])
        urlString= [NSString stringWithFormat:@"%@/api/rcd/test/getMyTest",myDelegate.ipString];
    
        
       
    
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  
                                  @"pageNumber":[NSString stringWithFormat:@"%d",pageIndex],
                                  @"token":token
                                  };
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
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
                        
                        if([orientation isEqualToString:@"down"])
                            self.tableView.headerRefreshingText = @"亲，没有更多数据了";
                        else
                            self.tableView.footerRefreshingText = @"亲，没有更多数据了";
                        [Alert showMessageAlert:@"抱歉,没有更多数据了" view:self];
                    }
                    else{
                        
                        if([orientation isEqualToString:@"down"])
                            [allDataFromServer removeAllObjects];
                        
                        for(NSDictionary *item in  articleArray ){
                            Test *model=[[Test alloc]init];
                            if([@"xlcs" isEqualToString:type]){

                            

                            model.testId=item [@"id"];
                            model.picUrl=item [@"picurl"];
                            model.title=item [@"title"];
                            NSLog(@"money1");
                            model.money=item [@"money"];
                            NSNumber *tem=item [@"joinpeoplenumber"];
                                model.testNumber=tem.stringValue;
//                            NSLog(model.money);
                            NSLog(@"money2");
                            }
                            else if ([@"wdcs" isEqualToString:type]){
                                model.testId=item [@"testid"];
                                model.picUrl=item [@"picurl"];
                                model.title=item [@"testname"];
                                NSLog(@"money1");
                                model.money=item [@"score"];
                                //用显示心理测试页面测试人数的label显示时间
                               
                                
                                /**
                                 *把时间搓NSNumber 转成用户看得懂的时间
                                 */
                                NSNumber *date=item [@"at"];
                                NSString *timeStamp2 =date.stringValue;
                                long long int date1 = (long long int)[timeStamp2 intValue];
                                NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
                                //用于格式化NSDate对象
                                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                //设置格式：zzz表示时区
                                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                //NSDate转NSString
                                NSString *currentDateString = [dateFormatter stringFromDate:date2];

                                model.testNumber=currentDateString;
                            }
                            [allDataFromServer addObject:model];
                        }
                        NSLog(@"mDataArticle项数为%i",[allDataFromServer count]);
                        NSLog(@"//更新界面");
                        //更新界面
                        [mTableView reloadData];
                    }
                    //            }
                }
                else
                {
                    [Alert showMessageAlert:@"抱歉，尚无文章可以阅读" view:self];
                }
            }
            
            else{
                
                if([@"token invalid" isEqualToString:[doc objectForKey:@"msg"]]){
                    [AppDelegate reLogin:self];
                }
                else{
                    NSString *msg=[NSString stringWithFormat:@"code是%d ： %@",[doc objectForKey:@"code"],[doc objectForKey:@"msg"]];
                    [Alert showMessageAlert:msg  view:self];
                }
            }
        }
        else
            NSLog(@"*****doc空***********");
        //        NSLog([self DataTOjsonString:responseObject]);
        //          NSLog([self convertToJsonData:dic]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
         if(-1009==error.code||-1016==error.code)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}



@end
