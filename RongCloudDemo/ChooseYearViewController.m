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
@interface ChooseYearViewController ()
@property (nonatomic, strong) CCZTableButton *tableButton;
@end

@implementation ChooseYearViewController{

    NSMutableArray *mDataExam;
//    好
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mDataExam=[[NSMutableArray alloc]init];
    
    
    [mDataExam addObject:@"高一第一次月考"];
    [mDataExam addObject:@"高一第二次考试"];
    [mDataExam addObject:@"第三次全市联考"];
    //    [mDataNotification addObject:@"第五次模拟考"];
    [mDataExam addObject:@"高一期中考试"];
    [mDataExam addObject:@"高一期末考试"];
    

    [self loadGradeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)query:(id)sender {
    
    
}
- (IBAction)select:(id)sender {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择学年"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"2015-2016学年", @"2014-2015学年",@"2013-2014学年",nil];
        actionSheet.actionSheetStyle = UIBarStyleDefault;
        [actionSheet showInView:self.view];
    
}


//UIActionSheet对话框选择监听事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"选择年级对话框监听事件,您选择了%i",buttonIndex);
    NSMutableArray *grade=[[NSMutableArray alloc]init];
    [grade addObject:@"2015-2016学年"];
    [grade addObject:@"2014-2015学年"];
    [grade addObject:@"2013-2014学年"];
    [grade addObject:@"null"];
    NSLog([grade objectAtIndex:buttonIndex]);
    if(buttonIndex!=[grade count]-1)
        
        [_mUIButtonSelect setTitle:[grade objectAtIndex:buttonIndex] forState:UIControlStateNormal];// 添加文字
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
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
    
        cell.imageView.image=[UIImage imageNamed:@"exam1.png"];
        cell.detailTextLabel.text=@"2017/12/21";
        cell.textLabel.text = [mDataExam objectAtIndex:indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherNotUseCollectionViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherNotUseCollectionViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)gradeTrend:(id)sender {
    
    QueryGradeTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"QueryGradeTableViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
    
}
#pragma mark 加载学年
-(void)loadGradeData {
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
                    
                    NSArray *articleArray=[doc objectForKey:@"data"];
                    if(0==[articleArray count]){
                        
                        
                        [Alert showMessageAlert:@"亲，没有更多数据了" view:self];
                        
                    }
                    else{
                        
                        
                        
                        for(NSDictionary *item in  articleArray ){
                            /*Article *model=[[Article alloc]init];
                            model.articleId=item [@"id"];
                            model.picUrl=item [@"picurl"];
                            model.title=item [@"title"];
                            model.author=item [@"author"];
                            
                            
                            //                    注意，publishat是NSNumber 类型的，所以不要用字符串去接收，否则报错
                            //                    -[__NSCFNumber rangeOfCharacterFromSet:]: unrecognized selector sent to instance 0x7fa5216589d0"，对于IOS开发感兴趣的同学可以参考一下： 这个算是类型的不匹配，就是把NSNumber类型的赋给字符串了自己还不知情，
                            
                            model.date=item [@"publishat"];
                            
                            
                            NSLog(@"******打印文章列表**********");
                            NSLog(@"文章articleId是%@",model.articleId);
                            NSLog(@"文章picUrl是%@",model.picUrl);
                            NSLog(@"文章title是%@",model.title);
                            NSLog(@"文章author是%@",model.author);
                            NSLog(@"文章publishat是%i",model.date);
                            //添加到数组以便显示到tableview
                            
                            
                            [allDataFromServer addObject:model];
                            */
                            
                        }
                        //NSLog(@"mDataArticle项数为%i",[allDataFromServer count]);
                        NSLog(@"//更新界面");
                        //更新界面
                        //[mTableView reloadData];
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
