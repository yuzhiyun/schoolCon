//
//  ClassGradeTableViewController.m
//  SchoolCon
//
//  Created by 秦启飞 on 2017/2/20.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ClassGradeTableViewController.h"
#import "MBProgressHUD.h"
#import "JsonUtil.h"
#import "AFNetworking.h"
#import "Alert.h"
#import "AppDelegate.h"
#import "TeacherNotUseCollectionViewController.h"

#import "StudentRank.h"
@interface ClassGradeTableViewController (){
    
    NSMutableArray *mAllData;
    
    
    UITableView *mTableView;

}

@end

@implementation ClassGradeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    mAllData=[[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    mTableView=tableView;
    
    return [mAllData count]+1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
   
    //序号
    UILabel *mUILabelOdrder=[cell viewWithTag:1];
    //学号
    UILabel *mUILabelStudentId=[cell viewWithTag:2];
    //姓名
    UILabel *mUILabelName=[cell viewWithTag:3];
    //班级排名
    UILabel *mUILabelCRank=[cell viewWithTag:4];
    //年级排名
    UILabel *mUILabelGRank=[cell viewWithTag:5];
    
    if(0==indexPath.row){
        mUILabelOdrder.text=@"序号";
        mUILabelStudentId.text=@"学号";
        mUILabelName.text=@"姓名";
        mUILabelCRank.text=@"班级排名";
        mUILabelGRank.text=@"年级排名";
        
    }else{
        mUILabelOdrder.font=[UIFont systemFontOfSize:16];
        [mUILabelOdrder setTextColor:[UIColor grayColor]];
        
        mUILabelStudentId.font=[UIFont systemFontOfSize:16];
        [mUILabelStudentId setTextColor:[UIColor grayColor]];
        
        mUILabelName.font=[UIFont systemFontOfSize:16];
        [mUILabelName setTextColor:[UIColor grayColor]];
        
        mUILabelCRank.font=[UIFont systemFontOfSize:16];
        [mUILabelCRank setTextColor:[UIColor grayColor]];
        
        mUILabelGRank.font=[UIFont systemFontOfSize:16];
        [mUILabelGRank setTextColor:[UIColor grayColor]];
        
        
        
         StudentRank *model=[mAllData objectAtIndex:indexPath.row-1];
    NSNumber *tem=[NSNumber numberWithLong:(indexPath.row)];
    mUILabelOdrder.text=tem.stringValue;
    
    mUILabelStudentId.text=model.studentId;
    
    
    mUILabelName.text=model.name;
    
    mUILabelCRank.text=model.crank;
   
    mUILabelGRank.text=model.grank;
    }
    
    
    
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    StudentRank *model=[mAllData objectAtIndex:indexPath.row-1];
    TeacherNotUseCollectionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherNotUseCollectionViewController"];
    nextPage->mExamId=mExamId;
    nextPage->mStudentId=model.studentId;
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];

}


-(void) loadData{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sch/score/classScore",myDelegate.ipString];
    
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
                                  @"examId":mExamId,
                                  @"classId":mClassId
                                  };
    
    
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
                        
                        //[mDataExam removeAllObjects];
                        
                        
                        
                        for(NSDictionary *item in  array ){
                            
                           
                           StudentRank *model=[[StudentRank alloc]init];
                            model.gradeId=item [@"id"];
                            model.studentId=item [@"studentId"];
                            model.grank=item [@"grank"];
                            model.name=item [@"name"];
                            model.crank=item [@"crank"];
                           
                            
                            
                            [mAllData addObject:model];
                            
                        }
                      //  NSLog(@"mAllData项数为%i",[mAllData count]);
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
