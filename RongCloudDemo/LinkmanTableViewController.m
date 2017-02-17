//
//  LinkmanTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "LinkmanTableViewController.h"
#import "LinkmanTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
#import "LinkMan.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "JsonUtil.h"
#import "MBProgressHUD.h"
#import "Alert.h"
#import "MJRefresh.h"
@interface LinkmanTableViewController ()

@end

@implementation LinkmanTableViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataRemark;
    NSMutableArray *mDataAvatar;
    
    NSMutableArray *allDataFromServer;
    
    UITableView *mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allDataFromServer=[[NSMutableArray alloc]init];
    //保存数据在群发页面使用
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    allDataFromServer=myDelegate.linkManArray;
    //[self loadData];
    
    
    
    
    
    // 2.集成刷新控件
    [self setupRefresh];
    
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    if(0==[myDelegate.linkManArray count]){
        
         allDataFromServer=[[NSMutableArray alloc]init];
        [Alert showMessageAlert:@"尚无联系人信息，请下拉刷新" view:self];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
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
    
    [self loadData];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    mTableView=tableView;
    
    return [allDataFromServer count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    LinkmanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[LinkmanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    //allDataFromServer=myDelegate.linkManArray;
    
    LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
    cell.UILabelName.text =model.name;
    cell.UILabelRemark.text = model.introduction;
    //    cell.UIImgAvatar.image=[UIImage imageNamed:[mDataAvatar objectAtIndex:indexPath.row]];
    if([@"private" isEqualToString: model.type]){
        
        
        NSString *picUrl=[NSString stringWithFormat:@"%@%@",myDelegate.ipString,model.picUrl];
        [cell.UIImgAvatar sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"icon_tx.png"]];
    }
    else
        cell.UIImgAvatar.image=[UIImage imageNamed:@"group.png"];
    cell.UIImgAvatar.layer.masksToBounds = YES;
    cell.UIImgAvatar.layer.cornerRadius = cell.UIImgAvatar.frame.size.height / 2 ;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
                LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
                if([@"private" isEqualToString: model.type]){
                    //新建一个聊天会话View Controller对象
                    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
                    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
                    chat.conversationType = ConversationType_PRIVATE;
                    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
                    chat.targetId =model.LinkmanId;
                    //设置聊天会话界面要显示的标题
                    chat.title = model.name;
                    //设置隐藏底部栏
                    chat.hidesBottomBarWhenPushed=YES;
                    //显示聊天会话界面
                    [self.navigationController pushViewController:chat animated:YES];
                }
                else{
                    //        LinkMan *group=[[LinkMan alloc]init];
                    //        group.type=@"group";
                    //        group.LinkmanId=@"1";
                    //        group.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
                    //        group.name=@"初二3班班群";
                    //        group.introduction=@"";
                    NSLog(@"群聊");
                    //新建一个聊天会话View Controller对象
                    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
                    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
                    chat.conversationType = ConversationType_GROUP;
                    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
                    chat.targetId = model.LinkmanId;
                    //设置聊天会话界面要显示的标题
                    chat.title = model.name;
                    //设置隐藏底部栏
                    chat.hidesBottomBarWhenPushed=YES;
                    //显示聊天会话界面
                    [self.navigationController pushViewController:chat animated:YES];
                }
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
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
    
    
    
    
}

#pragma mark 加载联系人列表
-(void)loadData {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString;
    
    urlString= [NSString stringWithFormat:@"%@/api/sys/user/contacts",myDelegate.ipString];
    
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  
                                  //@"pageNumber":[NSString stringWithFormat:@"%d",pageIndex],
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
                    
                    NSArray *array=[doc objectForKey:@"data"];
                    if(0==[array count]){
                        
                        [Alert showMessageAlert:@"抱歉,没有数据" view:self];
                        
                    }
                    else{
                        //单聊联系人信息
                        NSArray *contactsArray=[[doc objectForKey:@"data"] objectForKey:@"contacts"];
                        [allDataFromServer removeAllObjects];
                        for(NSDictionary *item in  contactsArray ){
                            LinkMan *model=[[LinkMan alloc]init];
                            model.LinkmanId=item [@"userId"];
                            model.picUrl=item [@"picurl"];
                            model.introduction=item [@"remark"];
                            model.name=item [@"name"];
                            model.type= @"private";
                            NSLog(model.name);
                            [allDataFromServer addObject:model];
                        }
                        //群聊联系人信息
                        NSArray *groupsArray=[[doc objectForKey:@"data"] objectForKey:@"groups"];
                        for(NSDictionary *item in  groupsArray ){
                            LinkMan *model=[[LinkMan alloc]init];
                            model.LinkmanId=item [@"id"];
                            //model.picUrl=item [@"picurl"];
                            model.name=item [@"name"];
                            NSLog(model.name);
                            [allDataFromServer addObject:model];
                        }
                        //保存数据在群发页面使用
                        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
                        myDelegate.linkManArray=allDataFromServer;
                        NSLog(@"allDataFromServer项数为%i",[allDataFromServer count]);
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
                
                
                // [Alert showMessageAlert:[doc objectForKey:@"msg"]  view:self];
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
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}



@end
