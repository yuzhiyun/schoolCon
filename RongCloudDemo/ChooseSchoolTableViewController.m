//
//  ChooseSchoolTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/25.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ChooseSchoolTableViewController.h"
#import "LoginViewController.h"
#import "ForgetPwdViewController.h"
#import "ActiveViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "School.h"
#import "Alert.h"
#import "DataBaseNSUserDefaults.h"
//#import "AppDelegate.h"
//#import "MBProgressHUD.h"
@interface ChooseSchoolTableViewController ()

@end

@implementation ChooseSchoolTableViewController{
    
    NSMutableArray *mDataSchool;
    
    
    //上传头像进度条，就是一个劲旋转的进度
    //    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择学校";
    //   navigationBar背景
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [self.navigationController.navigationBar setBarTintColor:myDelegate.navigationBarColor];
    //      navigationBar标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    //    返回箭头和文字的颜色，只要写一次就行了，是全局的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //    显示返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=NO;
    
    mDataSchool=[[NSMutableArray alloc]init];
    
    [self loadData];
    

   
   
    
    NSLog(@"这里是ChooseSchoolTableViewController，全局ip地址是 %@",myDelegate.ipString);
    //去掉多余的UITableView分割线
    self.tableView.tableFooterView=[[UIView alloc]init];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

#pragma mark 请求数据
-(void)loadData{
    //#import "AFNetworking.h"
    //#import "AppDelegate.h"
    //#import "MBProgressHUD.h"
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"%@/api/sch/school/get?appId=03a8f0ea6a&appSecret=b4a01f5a7dd4416c",myDelegate.ipString];
   
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
//    NSDictionary *parameters = @{
//                                 @"channelType":@"zxxx",
//                                 @"pageNumber":@"1"
//                                 };
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[self DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        /**
         *开始解析json
         */
        //NSString *result=[self DataTOjsonString:responseObject];
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            NSDictionary *data=[doc objectForKey:@"data"];
            if(data!=nil){
                NSArray *schoolArray=[data objectForKey:@"schools"];
                for(NSDictionary *item in  schoolArray ){
                    

                
                   School *model=[[School alloc]init];
                    model.schoolName=item [@"name"];
                    model.schoolId=item [@"id"];
                    NSLog(@"******打印学校**********");
                    NSLog(@"学校名称是%@",model.schoolName);
                    //添加到数组以便显示到tableview
                    [mDataSchool addObject:model];
                }
                //更新界面
                [mTableView reloadData];
            }
        }
        
        
        else
            NSLog(@"*****doc空***********");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        [Alert showMessageAlert:errorUser view:self];
    }];
}


/**
 *使用AFNetWorking 代替基础的NSURLConnection
 **
 /
 
 //-(void) getData{
 //
 //    //获取全局ip地址
 //    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
 //
 //    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sch/school/get?appId=03a8f0ea6a&appSecret=b4a01f5a7dd4416c",myDelegate.ipString];
 //
 //    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 //    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
 //    hud.labelText = @" 获取数据...";
 //    [hud show:YES];
 //
 //    NSURL *url=[NSURL URLWithString:urlString];
 //
 //    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
 //
 //    //    设置为post方法
 //    [request setHTTPMethod:@"POST"];
 //    //    post请求参数
 //    NSString *postParameters=@"phone=15111356294&dtype=json&key=d90f8fa635ffbc051ed51553cbf02f61";
 //    //    把参数封装到　body中
 //    NSData *body=[postParameters dataUsingEncoding:NSUTF8StringEncoding];
 //    //    设置body，对于post方法，参数是放在body中的
 //    [request setHTTPBody:body];
 //
 //
 //
 //    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
 //
 //
 //
 //}
 //
 //
 ////接收数据,并不是只会被调用一次的，数据被切割，该函数被调用多次。
 //-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
 //    //    NSLog(@"DATA=%@",data);
 //    //数据添加到backData
 //    [backData appendData:data];
 //}
 ////返回response，包括状态码等等信息
 //-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
 //
 //
 //    NSLog(@"didReceiveResponse函数 %@",response);
 //
 //    //初始化data
 //    backData=[[NSMutableData alloc]init];
 //
 //    //    [dataUILable setText:response];
 //}
 //
 ////请求结束
 //-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
 //
 //
 //
 //    //    隐藏对话框
 //    //    [self dismissViewControllerAnimated:YES  completion:nil];
 //
 //
 //    [hud hide:YES];
 //    /**
 //     *开始解析json
 //     */
//    NSString *result=[[NSString alloc] initWithData:backData encoding:NSUTF8StringEncoding];
//
//    NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSError *error=[[NSError alloc]init];
//    NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//
//
//    if(doc!=nil){
//        NSLog(@"*****doc不为空***********");
//        NSDictionary *data=[doc objectForKey:@"data"];
//        if(data!=nil){
//            NSArray *schoolArray=[data objectForKey:@"schools"];
//            for(NSDictionary *item in  schoolArray ){
//
//                NSString *schoolName=[item objectForKey:@"name"];
//                NSLog(@"******打印学校**********");
//                NSLog(@"学校名称是%@",schoolName);
//                //添加到数组以便显示到tableview
//                [mDataNotification addObject:schoolName];
//            }
//            //更新界面
//            [mTableView reloadData];
//        }
//    }
//    else
//        NSLog(@"*****doc空***********");
//    //    [dataTextview setText:result];
//    NSLog(@"序列化之前%@",result);
//    //   {
//    //        code = 0;
//    //        data =     {
//    //            schools =         (
//    //                               {
//    //                                   hasChildren = 0;
//    //                                   id = pi153odfasd;
//    //                                   name = "\U957f\U90e1\U4e2d\U5b66";
//    //                                   type = 0;
//    //                               },
//    //                               {
//    //                                   hasChildren = 0;
//    //                                   id = 1564do12spa;
//    //                                   name = "\U96c5\U793c\U4e2d\U5b66";
//    //                                   type = 0;
//    //                               }
//    //                               );
//    //        };
//    //        msg = ok;
//    //    }
//    id obj=[NSJSONSerialization JSONObjectWithData:backData options:0 error:nil];
//    NSLog(@"序列化之后%@",obj);
//
//
//}
//
////网络请求错误
//-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    [hud hide:YES];
//
//    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"访问错误%@",error]preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
//                                               style:UIAlertActionStyleDefault handler:nil];
//
//    //        信息框添加按键
//    [alert addAction:ok];
//
//
//    [self presentViewController:alert animated:YES completion:nil];
//
//
//    NSLog(@"❌错误 %@",error);
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    mTableView=tableView;
    return [mDataSchool count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    School *model=[mDataSchool objectAtIndex:indexPath.row];
    cell.textLabel.text =model.schoolName;
    cell.imageView.image=[UIImage imageNamed:@"Classroom.png"];
    
    cell.detailTextLabel.text=nil;
    return cell;
}
#pragma mark item点击事件
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    School *school=[mDataSchool objectAtIndex:indexPath.row];
     AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    myDelegate.schoolId=school.schoolId;
    
    [DataBaseNSUserDefaults setData: myDelegate.schoolId forkey:@"schoolId"];
    //登录
    if(1==self->index){
        //根据storyboard id来获取目标页面
        LoginViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //跳转
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    //激活
    else if(2==self->index){
        ActiveViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ActiveViewController"];
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    /*忘记密码
    else if(3==self->index){
        ForgetPwdViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
        [self.navigationController pushViewController:nextPage animated:YES];
    }*/
    
}

@end
