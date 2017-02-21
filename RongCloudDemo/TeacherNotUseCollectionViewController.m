//
//  TeacherNotUseCollectionViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/23.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "TeacherNotUseCollectionViewController.h"
#import "MBProgressHUD.h"
#import "JsonUtil.h"
#import "AFNetworking.h"
#import "Alert.h"
#import "AppDelegate.h"
#import "StudentGrade.h"
@interface TeacherNotUseCollectionViewController ()

@end

@implementation TeacherNotUseCollectionViewController{
    
    NSMutableArray *dataInOnerow;
    NSMutableArray *dataInOnerow2;
    
    NSMutableArray *mAllData;
    UITableView *mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mAllData=[[NSMutableArray alloc]init];
    
    
     /*
    dataInOnerow=[[NSMutableArray alloc]init];
    [dataInOnerow addObject:@"数学"];
    [dataInOnerow addObject:@"98"];
    [dataInOnerow addObject:@"90分/2"];
    [dataInOnerow addObject:@"86分/30"];
    
    dataInOnerow2=[[NSMutableArray alloc]init];
    [dataInOnerow2 addObject:@"英语"];
    [dataInOnerow2 addObject:@"80"];
    [dataInOnerow2 addObject:@"90分/3"];
    [dataInOnerow2 addObject:@"86分/20"];
    
    [allData addObject:dataInOnerow];
    [allData addObject:dataInOnerow2];
    */
    //mStudentId=@"";
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    mTableView=tableView;
    return [mAllData count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    //    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
//    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
//    cell.detailTextLabel.text=@"2017/12/21";
//    //    cell.tes
//    
//    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    //第一行显示文字，不显示具体的数据
   
    UILabel *mUILabelsubject=(UILabel *)[cell viewWithTag:1];
    UILabel *mUILabelScore=(UILabel *)[cell viewWithTag:2];
    //班级排名
    UILabel *mUILabelClass=(UILabel *)[cell viewWithTag:3];
    //年级排名
     UILabel *mUILabelSchool=(UILabel *)[cell viewWithTag:4];
    
    if(0==indexPath.row){
        mUILabelsubject.text=@"学科";
         mUILabelScore.text=@"成绩";
         mUILabelClass.text=@"班均分/班排名";
        mUILabelSchool.text=@"校均分/校排名";
        
        
        mUILabelsubject.font=[UIFont systemFontOfSize:16];
        [mUILabelsubject setTextColor:[UIColor blackColor]];
        
        mUILabelScore.font=[UIFont systemFontOfSize:16];
        [mUILabelScore setTextColor:[UIColor blackColor]];

        mUILabelClass.font=[UIFont systemFontOfSize:16];
        [mUILabelClass setTextColor:[UIColor blackColor]];
        
        mUILabelSchool.font=[UIFont systemFontOfSize:16];
        [mUILabelSchool setTextColor:[UIColor blackColor]];
        
    }else{
        
        StudentGrade *model=[mAllData objectAtIndex:indexPath.row-1];
        
        mUILabelsubject.text=model.course;
        mUILabelScore.text=model.score;
        mUILabelClass.text=model.classScore;
        mUILabelSchool.text=model.gradeScore;

    }
    
    
    return cell;
}
-(void) loadData{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sch/score/score",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    NSDictionary *parameters;
    if(mStudentId==nil){
    // 请求参数
    parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"token":token,
                                  @"examId":mExamId
                                  };
        NSLog(@"没有传参数mStudentId");
    }


    else{
        parameters = @{ @"appId":@"03a8f0ea6a",
                        @"appSecret":@"b4a01f5a7dd4416c",
                        @"token":token,
                        @"examId":mExamId,
                        @"studentId":mStudentId
                        
                        };
        
        NSLog(@"mStudentId=%@",mStudentId);
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
                    
                    

                    
                    _mUILabelTotal.text=[[doc objectForKey:@"data"]objectForKey:@"total"];
                    _mUILabelCmean.text=[[doc objectForKey:@"data"]objectForKey:@"tcmean"];
                    _mUILabelCrank.text=[[doc objectForKey:@"data"]objectForKey:@"tcrank"];
                    _mUILabelGmean.text=[[doc objectForKey:@"data"]objectForKey:@"tgmean"];
                    _mUILabelGrank.text=[[doc objectForKey:@"data"]objectForKey:@"tgrank"];
                    
                    NSArray *array=[[doc objectForKey:@"data"]objectForKey:@"scores"];
                    
                    if(0==[array count]){
                        [Alert showMessageAlert:@"抱歉,没有更多数据了" view:self];
                    }
                    else{
                        
                        //[mDataExam removeAllObjects];
                        
                        
                        
                        for(NSDictionary *item in  array ){
                            
                            //暂时用Notification这个类代替一下 考试类，
                            StudentGrade *model=[[StudentGrade alloc]init];
                            model.score=item [@"score"];
                            model.course=item [@"course"];
                            model.classScore=[NSString stringWithFormat:@"%@/%@",item [@"cmean"],item [@"crank"]];
                             model.gradeScore=[NSString stringWithFormat:@"%@/%@",item [@"gmean"],item [@"grank"]];
                            
                            
                            [mAllData addObject:model];
                            
                        }
                        NSLog(@"mAllData项数为%i",[mAllData count]);
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
