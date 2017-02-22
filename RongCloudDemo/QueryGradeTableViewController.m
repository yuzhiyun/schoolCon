//
//  QueryGradeTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "QueryGradeTableViewController.h"
#import "TeacherViewController.h"
#import "OptionViewController.h"
#import "TeacherNotUseCollectionViewController.h"
#import "ParentsViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "JsonUtil.h"
#import "Alert.h"
#import "AppDelegate.h"
#import "Subject.h"
#import "LineChartViewController.h"
@interface QueryGradeTableViewController ()

@end

@implementation QueryGradeTableViewController{
    
    NSMutableArray *mDataSubject;
    UITableView *mTableView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.title=@"选择类别";
    mDataSubject=[[NSMutableArray alloc]init];
    
    [self loadData];

}
/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    mTableView=tableView;
    return [mDataSubject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }

        //cell.imageView.image=[UIImage imageNamed:@"exam1.png"];
        //cell.detailTextLabel.text=@"2017/12/21";
    
    Subject *model=[mDataSubject objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.typeName;


    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Subject *model=[mDataSubject objectAtIndex:indexPath.row];
    //根据storyboard id来获取目标页面
    LineChartViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"LineChartViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    nextPage->typeId=model.typeId;
    nextPage->studentId=studentId;
    
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}

-(void)loadData{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sch/score/type",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    
    NSDictionary *parameters;
    if([AppDelegate isTeacher])
    // 请求参数
    parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"studentId":studentId
                                  };
    else{
        // 请求参数
        parameters = @{ @"appId":@"03a8f0ea6a",
                        @"appSecret":@"b4a01f5a7dd4416c",
                        @"token":token
                        
                        };
    }
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        //[self.tableView footerEndRefreshing];
        //[self.tableView headerEndRefreshing];
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
                    
                    NSArray *array=[doc objectForKey:@"data"];
                    if(0==[array count]){
                        
                        
                        [Alert showMessageAlert:@"抱歉,没有更多数据了" view:self];
                    }
                    else{
                        
                        for(NSDictionary *item in  array ){
                            Subject *model=[[Subject alloc]init];
                            model.typeId=item [@"typeId"];
                            model.typeName=item [@"typeName"];
                            [mDataSubject addObject:model];
                        }
                       // NSLog(@"mDataExam项数为%i",[mDataExam count]);
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
        //[self.tableView footerEndRefreshing];
        //[self.tableView headerEndRefreshing];
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
    

}
@end
