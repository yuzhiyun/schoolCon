//
//  Vp1TableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

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
@interface ArticleTableViewController ()

@end

@implementation ArticleTableViewController{
    
    NSMutableArray *allDataFromServer;
    UITableView *mTableView;
    //页面索引，分页查询数据，下拉刷新的时候需要使用到
    int pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    allDataFromServer=[[NSMutableArray alloc]init];
    
    //数据默认为先加载第一页
    pageIndex=1;
    [self loadData:pageIndex orientation:@"up"];
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSLog(@"token是%@",myDelegate.token);
    
    //   navigationBar背景
    
    [self.navigationController.navigationBar setBarTintColor:myDelegate.navigationBarColor];
    
    
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
    
}


#pragma mark 加载文章列表
-(void)loadData:(int)pageIndex orientation:(NSString *) orientation {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/cms/article/getList",myDelegate.ipString];
    
    if([@"xlzs"isEqualToString:type])
        urlString=[NSString stringWithFormat:@"%@/api/psy/knowledge/getList",myDelegate.ipString];
    else if([@"jiaoyu"isEqualToString:type]||[@"xinli"isEqualToString:type])
        urlString=[NSString stringWithFormat:@"%@/api/rcd/article/getMyCollect",myDelegate.ipString];
    
    
    
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
                                  @"token":token,
                                  @"articleType":type,
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
                        [Alert showMessageAlert:@"亲，没有更多数据了" view:self];
                        
                    }
                    else{
                        
                        if([orientation isEqualToString:@"down"])
                            [allDataFromServer removeAllObjects];
                        
                        for(NSDictionary *item in  articleArray ){
                            Article *model=[[Article alloc]init];
                            model.articleId=item [@"id"];
                            model.picUrl=item [@"picurl"];
                            model.title=item [@"title"];
                            model.author=item [@"author"];
                            
                            //                    注意，publishat是NSNumber 类型的，所以不要用字符串去接收，否则报错
                            //                    -[__NSCFNumber rangeOfCharacterFromSet:]: unrecognized selector sent to instance 0x7fa5216589d0"，对于IOS开发感兴趣的同学可以参考一下： 这个算是类型的不匹配，就是把NSNumber类型的赋给字符串了自己还不知情，
                            
                            model.date=item [@"publishat"];
                            
                            
                            //由于我的收藏那里获得的数据和文章json数据的key有一点区别,我需要重新设置一下
                            if([@"jiaoyu"isEqualToString:type]||[@"xinli"isEqualToString:type]){
                                model.articleId=item [@"articleid"];
                                model.picUrl=item [@"picurl"];
                                model.title=item [@"articlename"];
                                model.author=item [@"author"];
                                model.date=item [@"at"];
                            }
                            
                                
                            NSLog(@"******打印文章列表**********");
                            NSLog(@"文章articleId是%@",model.articleId);
                            NSLog(@"文章picUrl是%@",model.picUrl);
                            NSLog(@"文章title是%@",model.title);
                            NSLog(@"文章author是%@",model.author);
                            NSLog(@"文章publishat是%i",model.date);
                            //添加到数组以便显示到tableview
                            
                            
                            [allDataFromServer addObject:model];
                            
                            
                        }
                        NSLog(@"mDataArticle项数为%i",[allDataFromServer count]);
                        NSLog(@"//更新界面");
                        //更新界面
                        [mTableView reloadData];
                    }
                }
                else
                    [Alert showMessageAlert:@"抱歉，尚无文章可以阅读" view:self];
            }
            else
            {
                
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        
        [Alert showMessageAlert:errorUser view:self];
    }];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    return [allDataFromServer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Vp1TableViewCell *cell = (Vp1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        cell=[[Vp1TableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    
    Article *model=[allDataFromServer objectAtIndex:indexPath.row];
    NSLog(@"cellForRowAtIndexPath");
    
    cell.UILabelTitle.text=model.title;
    NSLog(@"model.title;");
    cell.UILabelTitle.numberOfLines=2;
    /**
     *NSNumber 转成用户看得懂的时间
     */
    NSString *timeStamp2 = model.date.stringValue;
    long long int date1 = (long long int)[timeStamp2 intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date2];
    cell.UILabelDate.text=currentDateString;
    cell.UILabelAuthor.text= model.author;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [cell.UIImgCover sd_setImageWithURL:[NSString stringWithFormat:@"%@%@",myDelegate.ipString,model.picUrl] placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    //    [cell.UIImgCover sd_setImageWithURL:model.picUrl placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    return cell;
}

#pragma mark 文章点击事件
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    ArticleDetailViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
    
    Article *model=[allDataFromServer objectAtIndex:indexPath.row];
    nextPage->articleId=model.articleId;
    nextPage->title=model.title;
    
    NSString *urlString;
    
    if([@"xlzs" isEqualToString:type]||[@"xinli" isEqualToString:type]){
        urlString=[NSString stringWithFormat:@"%@/api/psy/knowledge/getObject",myDelegate.ipString];
        model.articleType=@"xlzs";
    }
    else{
        urlString=[NSString stringWithFormat:@"%@/api/cms/article/getObject",myDelegate.ipString];
        model.articleType=@"zxxx";
    }
    
    
    nextPage->urlString=urlString;
    nextPage->article=model;
    nextPage->type=type;
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
    
}
@end
