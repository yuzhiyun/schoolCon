//
//  ChooseYearViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/15.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import "ChooseYearViewController.h"
#import "CCZTableButton.h"
#import "ParentsViewController.h"
#import "TeacherNotUseCollectionViewController.h"
#import "AppDelegate.h"
#import "JsonUtil.h"
#import "QueryGradeTableViewController.h"
#import "AFNetworking.h"
#import "Alert.h"
#import "MBProgressHUD.h"
#import "Notification.h"
#import "ClassGradeTableViewController.h"
@interface ChooseYearViewController ()
@property (nonatomic, strong) CCZTableButton *tableButton;
@end

@implementation ChooseYearViewController{
    
    NSMutableArray *mDataExam;
    NSMutableArray *mDataSemester;
    NSMutableArray *mDataClass;
    //NSInteger *semesterIndex;
    NSString *semester;
    NSString *class;
    // NSString *classId;
    
    UITableView *mTableView;
    NSString *selectType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if(![AppDelegate isTeacher]){
        [_mUIButtonSelectClass setHidden:YES];
        [_mUILabelSelectClassKey setHidden:YES];
    }
    //@property (weak, nonatomic) IBOutlet UIButton *mUIButtonSelectClass;
    
    //@property (weak, nonatomic) IBOutlet UILabel *mUILabelSelectClassKey;
    
    
        
    mDataExam=[[NSMutableArray alloc]init];
    mDataSemester=[[NSMutableArray alloc]init];
    mDataClass=[[NSMutableArray alloc]init];
    
    //[mDataExam addObject:@"尚未获得考试列表信息"];
    
    [self loadSemesters];
    
    
    [_mUIButtonSelect setTitle:@"尚未获取到" forState:UIControlStateNormal];
    [_mUIButtonSelectClass setTitle:@"尚未获取到" forState:UIControlStateNormal];
    
    class=@"";
    //classId=@"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)query:(id)sender {
    
    if(0==[mDataSemester count])
        [Alert  showMessageAlert:@"尚未选择学年" view:self];
    else{
        
        // NSLog([mDataSemester objectAtIndex:semesterIndex-1]);
        MBProgressHUD *hud;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
        hud.labelText = @" 获取数据...";
        [hud show:YES];
        //获取全局ip地址
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        
        NSString *urlString= [NSString stringWithFormat:@"%@/api/sch/score/exam",myDelegate.ipString];
        
        //创建数据请求的对象，不是单例
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //设置响应数据的类型,如果是json数据，会自动帮你解析
        //注意setWithObjects后面的s不能少
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
        //避免乱码
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSString *token=myDelegate.token;
        NSDictionary *parameters;
        //服务器是通过我是否传递了classId来判断是否是老师
        if([AppDelegate isTeacher]){
            // 请求参数
            parameters = @{ @"appId":@"03a8f0ea6a",
                            @"appSecret":@"b4a01f5a7dd4416c",
                            @"token":token,
                            @"semester":semester,
                            @"classId":class
                            };
        }else{
            // 请求参数
            parameters = @{ @"appId":@"03a8f0ea6a",
                            @"appSecret":@"b4a01f5a7dd4416c",
                            @"token":token,
                            @"semester":semester
                            };
        }
        NSLog(class);
        NSLog(semester);
        
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
                            
                            [mDataExam removeAllObjects];
                            
                            
                            
                            for(NSDictionary *item in  array ){
                                //暂时用Notification这个类代替一下 考试类，
                                Notification *model=[[Notification alloc]init];
                                model.articleId=item [@"id"];
                                model.title=item [@"name"];
                                model.publishat=item [@"date"];
                                
                                [mDataExam addObject:model];
                            }
                            NSLog(@"mDataExam项数为%i",[mDataExam count]);
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
    
}
- (IBAction)selectClass:(id)sender {
    
    selectType=@"class";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择班级"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIBarStyleDefault;
    
    //Notification *model=
    for(Notification *item in mDataClass)
        [actionSheet addButtonWithTitle:item.title];
    
    [actionSheet showInView:self.view];
}

- (IBAction)select:(id)sender {
    
    selectType=@"grade";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择学年"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIBarStyleDefault;
    
    for(NSString *item in mDataSemester)
        [actionSheet addButtonWithTitle:item];
    //[actionSheet addButtonWithTitle:@"test"];
    //[mDataSemester addObject:@"test"];
    
    
    [actionSheet showInView:self.view];
}


//UIActionSheet对话框选择监听事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    NSLog(@"选择对话框监听事件,您选择了%i",buttonIndex);
    
    //NSLog([grade objectAtIndex:buttonIndex]);
    //if(buttonIndex!=[mDataSemester count]-1)
    if(buttonIndex!=0){
        // 添加文字
        if([@"grade" isEqualToString:selectType]){
            [_mUIButtonSelect setTitle:[mDataSemester objectAtIndex:buttonIndex-1] forState:UIControlStateNormal];
            
        }else{
            Notification *model=[mDataClass objectAtIndex:buttonIndex-1] ;
            [_mUIButtonSelectClass setTitle:model.title forState:UIControlStateNormal];
        }
        //semesterIndex=buttonIndex;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    mTableView=tableView;
    //最后一项是查看成绩变化趋势
    return [mDataExam count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    Notification *model=[mDataExam objectAtIndex:indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:@"exam1.png"];
    cell.detailTextLabel.text=model.publishat;
    cell.textLabel.text = model.title;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(![AppDelegate isTeacher]){
        Notification *model=[mDataExam objectAtIndex:indexPath.row];
        TeacherNotUseCollectionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherNotUseCollectionViewController"];
        nextPage->mExamId=model.articleId;
        nextPage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:nextPage animated:YES];
    }else{
        Notification *model=[mDataExam objectAtIndex:indexPath.row];
        ClassGradeTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ClassGradeTableViewController"];
        nextPage->mExamId=model.articleId;
        nextPage->mClassId=class;
        nextPage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:nextPage animated:YES];
        
    }
    
}


#pragma mark 加载学年
-(void)loadSemesters {
    //MBProgressHUD *hud;
    //hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    //hud.labelText = @" 获取数据...";
    //[hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sch/score/semester",myDelegate.ipString];
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
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
            if([[doc objectForKey:@"code"] isKindOfClass:[NSNumber class]])
                NSLog(@"code 是 NSNumber");
            //判断code 是不是0
            NSNumber *zero=[NSNumber numberWithInt:(0)];
            NSNumber *code=[doc objectForKey:@"code"];
            if([zero isEqualToNumber:code])
            {
                if(nil!=[doc allKeys]){
                    
                    NSArray *array=[[doc objectForKey:@"data"]objectForKey:@"semesters"];
                    if(0==[array count]){
                        [Alert showMessageAlert:@"亲，没有更多数据了" view:self];
                    }
                    else{
                        for(NSDictionary *item in  array ){
                            [mDataSemester addObject:item];
                        }
                        if([mDataSemester count]!=0){
                            [_mUIButtonSelect setTitle:[mDataSemester objectAtIndex:0] forState:UIControlStateNormal];
                            semester =[mDataSemester objectAtIndex:0];
                        }
                        NSLog(@"//更新界面");
                        //更新界面
                        //[mTableView reloadData];
                    }
                    if(![@"parent" isEqualToString: [[doc objectForKey:@"data"]objectForKey:@"type"]]){
                        //班级
                        NSArray *arrayClass=[[doc objectForKey:@"data"]objectForKey:@"class"];
                        if(0==[arrayClass count]){
                            [Alert showMessageAlert:@"亲，没有更多数据了" view:self];
                        }
                        else{
                            for(NSDictionary *item in  arrayClass ){
                                
                                Notification *model=[[Notification alloc]init];
                                model.articleId=item[@"id"];
                                model.title=item[@"name"];
                                [mDataClass addObject:model];
                            }
                            if([mDataClass count]!=0){
                                
                                Notification *model=[mDataClass objectAtIndex:0];
                                [_mUIButtonSelectClass setTitle:model.title forState:UIControlStateNormal];
                                class =model.articleId;
                                
                            }
                            NSLog(@"//更新界面");
                            //更新界面
                            //[mTableView reloadData];
                        }
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
        
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        
        [Alert showMessageAlert:errorUser view:self];
    }];}


@end
