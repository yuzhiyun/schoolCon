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
@interface ChooseSchoolTableViewController ()

@end

@implementation ChooseSchoolTableViewController{
    
    NSMutableArray *mDataNotification;
    
        UIAlertController *alert;
        
        
        
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择学校";
    
    
    
    
    
    
    
    //    navigationBar背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
    //      navigationBar标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    //    返回箭头和文字的颜色，只要写一次就行了，是全局的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //    显示返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=NO;
    
    mDataNotification=[[NSMutableArray alloc]init];
    [mDataNotification addObject:@"长郡中学"];
    [mDataNotification addObject:@"长沙第一中学"];
    [mDataNotification addObject:@"长沙师大附中"];
    [mDataNotification addObject:@"铁道小学"];
    [mDataNotification addObject:@"湖南第一中学"];
    [mDataNotification addObject:@"长沙市第一中学"];
    
    

}

-(void) viewWillAppear:(BOOL)animated{
    //获取数据
    [self getData];

}
-(void) getData{
    
    //    NSString *urlString=@"http://www.kuaidi100.com/query?type=ems&postid=11";
//    NSString *urlString=@"http://apis.juhe.cn/mobile/get";
    
        NSString *urlString=@"http://192.168.217.1:8080/api/sch/school/get?appId=03a8f0ea6a&appSecret=b4a01f5a7dd4416c";
    
    NSURL *url=[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    
    //    设置为post方法
    [request setHTTPMethod:@"POST"];
    //    post请求参数
    NSString *postParameters=@"phone=15111356294&dtype=json&key=d90f8fa635ffbc051ed51553cbf02f61";
    //    把参数封装到　body中
    NSData *body=[postParameters dataUsingEncoding:NSUTF8StringEncoding];
    //    设置body，对于post方法，参数是放在body中的
    [request setHTTPBody:body];
    
    
    
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    


}


//接收数据,并不是只会被调用一次的，数据被切割，该函数被调用多次。
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //    NSLog(@"DATA=%@",data);
    //数据添加到backData
    [backData appendData:data];
}
//返回response，包括状态码等等信息
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    NSLog(@"didReceiveResponse函数 %@",response);
    
    //初始化data
    backData=[[NSMutableData alloc]init];
    
    //    [dataUILable setText:response];
}

//请求结束
-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    
    //    隐藏对话框
    [self dismissViewControllerAnimated:YES  completion:nil];
    
    
    /**
     *开始解析json
     */
    NSString *result=[[NSString alloc] initWithData:backData encoding:NSUTF8StringEncoding];
    
    NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error=[[NSError alloc]init];
    NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    
    if(doc!=nil){
        NSLog(@"*****doc不为空***********");
         NSDictionary *data=[doc objectForKey:@"data"];
        if(data!=nil){
        NSArray *schoolArray=[data objectForKey:@"schools"];
        for(NSDictionary *item in  schoolArray ){
        
            NSString *schoolName=[item objectForKey:@"name"];
            NSLog(@"******打印学校**********");
            NSLog(@"学校名称是%@",schoolName);
        }
        }
    }
    else
        NSLog(@"*****doc空***********");
//    [dataTextview setText:result];
    NSLog(@"序列化之前%@",result);
//   {
//        code = 0;
//        data =     {
//            schools =         (
//                               {
//                                   hasChildren = 0;
//                                   id = pi153odfasd;
//                                   name = "\U957f\U90e1\U4e2d\U5b66";
//                                   type = 0;
//                               },
//                               {
//                                   hasChildren = 0;
//                                   id = 1564do12spa;
//                                   name = "\U96c5\U793c\U4e2d\U5b66";
//                                   type = 0;
//                               }
//                               );
//        };
//        msg = ok;
//    }
    
    
    
    id obj=[NSJSONSerialization JSONObjectWithData:backData options:0 error:nil];
    NSLog(@"序列化之后%@",obj);
    
    
}

//网络请求错误
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [alert setMessage:@"请求错误"];
    NSLog(@"❌错误 %@",error);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mDataNotification count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [mDataNotification objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"school.png"];
    cell.detailTextLabel.text=nil;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    //忘记密码
    else if(3==self->index){
        ForgetPwdViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    
}

@end
