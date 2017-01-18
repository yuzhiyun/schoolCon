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
    PhysicalTest *model=[[PhysicalTest alloc]init];
    model.testId=@"1";
    model.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    model.title=@"下拉刷新数据";
    model.price=@"600";
    model.testNumber=@"1234";
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [allDataFromServer insertObject:model atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    PhysicalTest *model=[[PhysicalTest alloc]init];
    model.testId=@"1";
    model.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    model.title=@"向上拉。。。。刷新数据";
    model.price=@"600";
    model.testNumber=@"1234";
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [allDataFromServer addObject:model];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
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
    cell.UILabelPrice.text= model.money.stringValue;
    
//    cell.UILabelNumOfTest.text=[NSString stringWithFormat:@"%i",  model.testNumber];

//    cell.UIImageViewCover.image=[UIImage imageNamed:[mImg objectAtIndex:indexPath.row]];
//    

    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSString *picUrl=[NSString stringWithFormat:@"%@%@",myDelegate.ipString,model.picUrl];
    
    NSLog(picUrl);
    [cell.UIImageViewCover sd_setImageWithURL: picUrl placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    
    
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Test *model=[allDataFromServer objectAtIndex:indexPath.row];
    
    //根据storyboard id来获取目标页面
    TestIntroductionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestIntroductionViewController"];
//    //    传值
    nextPage->testId=model.testId;
//    nextPage->pubString=[mDataNotification objectAtIndex:indexPath.row];
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
    
        
        urlString= [NSString stringWithFormat:@"%@/api/psy/test/getList",myDelegate.ipString];
    
        
       
    
    
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
                        for(NSDictionary *item in  articleArray ){
                            Test *model=[[Test alloc]init];
                            model.testId=item [@"id"];
                            model.picUrl=item [@"picurl"];
                            model.title=item [@"title"];
                            NSLog(@"money1");
                            model.money=item [@"money"];
//                            NSLog(model.money);
                            NSLog(@"money2");
                            if([orientation isEqualToString:@"up"])
                                [allDataFromServer addObject:model];
                            else
                                [allDataFromServer addObject:model ];
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
                [Alert showMessageAlert:[doc objectForKey:@"msg"]  view:self];
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
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}



@end
