//
//  ConsultTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/7.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ConsultTableViewController.h"
#import "MJRefresh.h"
#import "ConcreteConsultViewController.h"
#import "Alert.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "JsonUtil.h"
#import "Consult.h"

@interface ConsultTableViewController ()

@end

@implementation ConsultTableViewController{
//    NSMutableArray *mDataConsult;
    NSMutableArray *allDataFromServer;
    UITableView *mTableView;
    //页面索引，分页查询数据，下拉刷新的时候需要使用到
    int pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    mDataConsult=[[NSMutableArray alloc]init];
//    [mDataConsult addObject:@"初始数据"];
//    [mDataConsult addObject:@"初始数据"];
//    [mDataConsult addObject:@"初始数据"];
//    [mDataConsult addObject:@"初始数据"];
//    [mDataConsult addObject:@"初始数据"];
    // 2.集成刷新控件
    [self setupRefresh];
    
    [self loadData:1 orientation:@"down"];
    
    allDataFromServer=[[NSMutableArray alloc]init];
    
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    //第一段之显示一条数据
    if(0==section)
        return 1;
    else
    return [allDataFromServer count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    //    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
    
    if(1==indexPath.section){
        
        Consult *model=[allDataFromServer objectAtIndex:indexPath.row];
        
        
    
    UILabel *mUILabelName=(UILabel *)[cell viewWithTag:1];
    mUILabelName.text=model.name;
    UILabel *mUILabelTitle=(UILabel *)[cell viewWithTag:2];
    mUILabelTitle.text=model.title;
    
    UILabel *mUILabelSpecialty=(UILabel *)[cell viewWithTag:3];
    mUILabelSpecialty.text=model.goodAt;
        
        UIImageView  *mUIImageView=(UIImageView *)[cell viewWithTag:5];
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        [mUIImageView sd_setImageWithURL:[NSString stringWithFormat:@"%@%@",myDelegate.ipString,model.picUrl] placeholderImage:[UIImage imageNamed:@"icon_tx.png"]];
//    mUILabelSpecialty.text=[mDataConsult objectAtIndex:indexPath.row];
        
    }
    else{
        
        
        
        
        
        UILabel *mUILabelName=(UILabel *)[cell viewWithTag:1];
        mUILabelName.text=@"心理热线";
        UILabel *mUILabelTitle=(UILabel *)[cell viewWithTag:2];
        mUILabelTitle.text=@"";
        
        UILabel *mUILabelSpecialty=(UILabel *)[cell viewWithTag:3];
         UILabel *mUILabelSpecialtyLeft=(UILabel *)[cell viewWithTag:4];
        mUILabelSpecialtyLeft.text=@"400-888-666";
        //mUILabelSpecialty.text=@"认知行为治疗";
        mUILabelSpecialty.text=@"";
        
        UIImageView *mUIImageView=(UIImageView *)[cell viewWithTag:5];
        mUIImageView.image=[UIImage imageNamed:@"phoneConsult.png"];
    
    }
    return cell;
}


-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if(0==section)
        return @"电话咨询";
    else
        return @"心理咨询师";
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(0==indexPath.section){
        
        NSLog(@"拨打电话");
        //会直接拨打电话过去，而不仅仅是跳转到拨号界面
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-888-666"]];
        //会有弹出框提醒用户是否拨打电话
    UIWebView * callWebview = [[UIWebView alloc]init];
        
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:400-888-666"]]];
        
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
    }else{
    
    Consult *model=[allDataFromServer objectAtIndex:indexPath.row];
    
    
    //根据storyboard id来获取目标页面
    ConcreteConsultViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ConcreteConsultViewController"];
    
    nextPage->consultId=model.consultId;
    //    传值
//    nextPage->pubString=[recipes objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    }
}


#pragma mark 加载咨询师列表
-(void)loadData:(int)pageIndex orientation:(NSString *) orientation {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/psy/consultant/getList",myDelegate.ipString];
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
                        [Alert showMessageAlert:@"亲，没有更多数据了" view:self];
                    }
                    else{
                        if([orientation isEqualToString:@"down"])
                            [allDataFromServer removeAllObjects];
                        for(NSDictionary *item in  articleArray ){
                            
                            Consult *model=[[Consult alloc]init];
                            model.consultId=item [@"id"];
                            model.picUrl=item [@"picurl"];
                            model.title=item [@"title"];
                            model.name=item [@"name"];
                            model.goodAt=item[@"goodat"];
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
//ConcreteConsultViewController
@end
