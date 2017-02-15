//
//  TestViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "TestViewController.h"
#import "TestTableViewCell.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Article.h"
#import "JsonUtil.h"
#import "MJRefresh.h"
#import "Test.h"
#import "TestResultViewController.h"
#import "Alert.h"
@interface TestViewController ()

@end

@implementation TestViewController{
    
    //当前题目index
    int indexOfExercise;
    //当前题目被选中答案的index
    int indexOfAnswer;
    //来自服务器的所有题目数据
    NSMutableArray *mAllData;
    //用于刷新tableView
    UITableView *mTableView;
    //    int answerArray
    NSMutableArray *answerArray;
    //记录测试题目的每个选项的分数
    NSMutableArray *scoreArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    answerArray={1};
    self.title=pubString;
    self.title=@"心理测试";
    
    
    //    默认显示第一个题目
    indexOfExercise=0;
    //默认没有答案被选中
    indexOfAnswer=-1;
    //    填充题目
    mAllData=[[NSMutableArray alloc]init];
    

//    [self setTitle];
    answerArray=[[NSMutableArray alloc]init];
    scoreArray=[[NSMutableArray alloc]init];
//    [answerArray addObject:@"-1"];
    [self loadData];
}

-(void) setTitle{
    UILabelTitle.text=[[mAllData objectAtIndex:indexOfExercise] objectAtIndex:0];
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
    
    //    此处存储一下这个tableView，以便在切换到下一个题目的时候，reload数据
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    if(0==[mAllData count]){
        return 0;
        NSLog(@"****一开始是0*");
    }
    
    else
        return [[mAllData  objectAtIndex:indexOfExercise] count]-1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        
        cell=[[TestTableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    NSMutableArray *mEntity=[mAllData objectAtIndex:indexOfExercise];
    
    
    //    NSString *t1=[mTitle objectAtIndex:indexPath.row];
    //    [mItem1 objectAtIndex:indexOfExercise]
    cell.UILabelExerciseItem.numberOfLines=2;
    cell.UILabelExerciseItem.text=[mEntity objectAtIndex:indexPath.row+1];
    
    
    if(indexOfAnswer==indexPath.row|| [[answerArray objectAtIndex:indexOfExercise]isEqualToString:[NSString stringWithFormat: @"%i",indexPath.row]])
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"selected2.png"];
    else
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"un_selected.png"];
    
    
    return cell;
}

- (IBAction)lastExercise:(id)sender {
    if(-1==indexOfAnswer && [[answerArray objectAtIndex:indexOfExercise]isEqualToString:[NSString stringWithFormat: @"%i",-1]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请先作答此题，才能切换题目"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        indexOfExercise--;
        if(indexOfExercise>=0){
            [self setTitle];
            //所有item置于不被选中状态
            indexOfAnswer=-1;
            [mTableView reloadData];
        }
        else{
            indexOfExercise++;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"这已经是第一题了"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}


//切换到下一个题目
- (IBAction)nextExercise:(id)sender {
    if(-1==indexOfAnswer && [[answerArray objectAtIndex:indexOfExercise]isEqualToString:[NSString stringWithFormat: @"%i",-1]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请先作答此题，才能切换题目"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        indexOfExercise++;
        if(indexOfExercise<[mAllData count]){
            [self setTitle];
            //所有item置于不被选中状态
            indexOfAnswer=-1;
            [mTableView reloadData];
        }
        else{
            indexOfExercise--;
            
            //打印自己的作答选项
            
            
            NSNumber *total=[NSNumber numberWithInt:(0)];
            for(int i=0;i<[answerArray count];i++){
                NSString *answer=[answerArray objectAtIndex:i];
                NSLog(@"答案是%@", answer);
                NSLog(@"答案对应的分数是%@",[[scoreArray objectAtIndex:i] objectAtIndex: [answer intValue]]);
                
                NSNumber *a=[[scoreArray objectAtIndex:i] objectAtIndex: [answer intValue]];
                //NSLog(@"分%i",[a intValue]);
                total=[NSNumber numberWithInt:([total intValue]+[a intValue])];;
            }
            
            NSLog(@"总分%i",[total intValue]);
                
            //打印自己选项对应的分数
            //NSMutableArray *scoreArray;
            /*
            for(NSMutableArray *scoreItem in scoreArray){
                for(NSString *score in scoreItem)
                    NSLog(@"答案对应的分数是%@",score);
            }
            */
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"已经是最后一题了，请提交答案"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            [alert show];
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"已经是最后一题了，请提交答案" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                           NSLog(@"");
                                                           TestResultViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"TestResultViewController"];
                                                           nextPage->testId=testId;
                                                           nextPage->testName=testName;
                                                           nextPage->picUrl=picUrl;
                                                           
                                                           
                                                           nextPage->score=[NSString  stringWithFormat:@"%i",[total intValue]];
                                                           
                                                           nextPage.hidesBottomBarWhenPushed=YES;
                                                           [self.navigationController pushViewController:nextPage animated:YES];
                                                       }];
            //信息框添加按键
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

//把checkbox的图标改成被选中的
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    TestTableViewCell *cell=(TestTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    //    self tableView:<#(nonnull UITableView *)#> cellForRowAtIndexPath:<#(nonnull NSIndexPath *)#>
    
    //如果和上一次点击同一个item，就取消掉那个item被选中状态
    if(indexPath.row==indexOfAnswer){
        indexOfAnswer=-1;
        [answerArray insertObject:@"-1" atIndex:indexOfExercise];
        [answerArray removeObjectAtIndex:indexOfExercise+1];
    }
    
    else{
        //选中被点击item
        indexOfAnswer=indexPath.row;
        //数字int转为string
        NSString *answer=[NSString stringWithFormat: @"%i",indexOfAnswer];
        [answerArray insertObject:answer atIndex:indexOfExercise];
        [answerArray removeObjectAtIndex:indexOfExercise+1];
    }
    [mTableView reloadData];
}

#pragma mark 加载做题数据
-(void)loadData{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString;
    urlString= [NSString stringWithFormat:@"%@/api/psy/test/getTest",myDelegate.ipString];
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
                                  @"id":testId
                                  };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//        [self.tableView headerEndRefreshing];
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

                
                    NSDictionary *data=[doc objectForKey:@"data"];
                NSArray *questionArray=[data objectForKey:@"psy_questions"];
                int index=0;
                for(NSDictionary *item in  questionArray){
                    index++;
//                    NSUInteger *index=[questionArray indexOfObject:item];
                    NSMutableArray *entity=[[NSMutableArray alloc]init];
                 //   NSLog(@"*****************************************************************");
                    
                    NSString *content=[item objectForKey:@"content"];
                  
                    //非常奇怪，这里数数是从8开始的，我就给他剪去7
                    [entity addObject:[NSString stringWithFormat:@"%i、%@", index ,content]];
                    
                    
                    NSArray *optionArray=[item objectForKey:@"psy_options"];
                    //记录分数
                    NSMutableArray *scoreItem=[[NSMutableArray alloc]init];
                    
                    for(NSDictionary *item2 in  optionArray){
                        [entity addObject:[item2 objectForKey:@"optionContent"]];
                        //记录分数
                        [scoreItem addObject:[item2 objectForKey:@"optionScore"]];
                    }
                    //记录分数
                    [scoreArray addObject:scoreItem];
                    
                    //for(NSString * item in entity)
                      //  NSLog(item);
                    [mAllData addObject:entity];
                    //填充-1到答案数组里面,之所以使用这种for循环，是因为i是int，[mAllData count]转不过来
                    [answerArray addObject:@"-1"];
                }
                
                [self setTitle];
                [mTableView reloadData];
                        NSLog(@"mAllData项数为%i",[mAllData count]);
                        NSLog(@"//更新界面");
                        //更新界面
                        [mTableView reloadData];

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
        //        NSLog([self DataTOjsonString:responseObject]);
        //          NSLog([self convertToJsonData:dic]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {


        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}


@end
