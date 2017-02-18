//
//  ShalongTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ShalongTableViewController.h"
#import "ShalongTableViewCell.h"
#import "DetailYuluViewController.h"
#import "UIImageView+WebCache.h"
#import "Activity.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ArticleTableViewController.h"
#import "Vp1TableViewCell.h"
#import "ArticleDetailViewController.h"
#import "AppDelegate.h"
#import "WMPageController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Article.h"
#import "JsonUtil.h"
#import "MJRefresh.h"
#import "Alert.h"
#import "LoginViewController.h"
#import "DataBaseNSUserDefaults.h"
@interface ShalongTableViewController ()

@end

@implementation ShalongTableViewController{
    NSMutableArray *allDataFromServer;
    UITableView *mTableView;
    //页面索引，分页查询数据，下拉刷新的时候需要使用到
    int pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据默认为先加载第一页
    pageIndex=1;
    [self loadData:pageIndex orientation:@"up"];
    self.title=@"岳麓沙龙";
    //   navigationBar背景
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [self.navigationController.navigationBar setBarTintColor:myDelegate.navigationBarColor];

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    // 2.集成刷新控件
    [self setupRefresh];
    allDataFromServer= [[NSMutableArray alloc]init];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    return [allDataFromServer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShalongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        cell=[[ShalongTableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Activity *model=[allDataFromServer objectAtIndex:indexPath.row];
    //    NSString *t1=[mData objectAtIndex:indexPath.row];
    //    cell.UILabelTitle.text=t1;
    cell.UILabelTitle.text=model.title;
    cell.UILabelDate.text=model.date;
    cell.UILabelPlace.text=model.place;
    cell.UILabelPublisher.text=model.publisher;
    //    cell.UIImgCover.image=[UIImage imageNamed:[mImg objectAtIndex:indexPath.row]];
    //        加载图片,如果加载不到图片，就显示favorites.png
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [cell.UIImgCover sd_setImageWithURL: [NSString stringWithFormat:@"%@%@",myDelegate.ipString,model.picUrl] placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //根据storyboard id来获取目标页面
    DetailYuluViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailYuluViewController"];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    Activity *model=[allDataFromServer objectAtIndex:indexPath.row];
    nextPage->activityId=model.activityId;
    nextPage->activityType=type;
    nextPage->activityName=model.title;
    nextPage->picurl=model.picUrl;
    nextPage->title=model.title;
    

    nextPage->host=model.publisher;
    nextPage->date=model.date;
    nextPage->place=model.place;
    nextPage->price=model.price;
    
    
    NSString *urlString;
    
    if([@"xlhd" isEqualToString:type])
        urlString=[NSString stringWithFormat:@"%@/api/psy/activity/getObject",myDelegate.ipString];
    else
        urlString=[NSString stringWithFormat:@"%@/api/cms/activity/getObject",myDelegate.ipString];
    nextPage->urlString=urlString;
    //    传值
    //    nextPage->pubString=[mData objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
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
    if([@"ylsl" isEqualToString:type])
        
    urlString= [NSString stringWithFormat:@"%@/api/cms/activity/getList",myDelegate.ipString];
    else
        
       urlString= [NSString stringWithFormat:@"%@/api/psy/activity/getList",myDelegate.ipString];
    
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"channelType":type,
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
            
            //NSLog([doc objectForKey:@"code"]);
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
                            Activity *model=[[Activity alloc]init];
                            model.activityId=item [@"id"];
                            model.picUrl=item [@"picurl"];
                            model.title=item [@"title"];
                            model.publisher=item [@"author"];
                            model.place=item[@"place"];
                            
                            
                         /**
                                *把时间搓NSNumber 转成用户看得懂的时间
                                */
                            NSNumber *date=item [@"starttime"];
                            NSString *timeStamp2 =date.stringValue;
                            long long int date1 = (long long int)[timeStamp2 intValue];
                            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
                            //用于格式化NSDate对象
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            //设置格式：zzz表示时区
                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            //NSDate转NSString
                            NSString *currentDateString = [dateFormatter stringFromDate:date2];
                            model.date=currentDateString;
                            [allDataFromServer addObject:model];
                        }
                        NSLog(@"mDataArticle项数为%i",[allDataFromServer count]);
                        NSLog(@"//更新界面");
                        //更新界面
                        [mTableView reloadData];
                    }
                }
                else
                {
                     [Alert showMessageAlert:@"抱歉，尚无数据" view:self];
                }
            }
            else{
                //判断code 是不是-1,(-2的情况也出现过,还是用msg来判断吧，虽然不规范),如果是那么token失效，需要让用户重新登录
               // if([[NSNumber numberWithInt:(-1)] isEqualToNumber:[doc objectForKey:@"code"]]
                   
                   
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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
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
