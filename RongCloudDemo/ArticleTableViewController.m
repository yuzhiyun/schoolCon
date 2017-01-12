//
//  Vp1TableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ArticleTableViewController.h"
#import "Vp1TableViewCell.h"
#import "ArticleDetailViewController.h"
#import "AppDelegate.h"
#import "WMPageController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Article.h"
#import "JsonUtil.h"
@interface ArticleTableViewController ()

@end

@implementation ArticleTableViewController{
    
    NSMutableArray *mDataArticle;
    UITableView *mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mDataArticle=[[NSMutableArray alloc]init];
    
    
    [self loadData];
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSLog(@"token是%@",myDelegate.token);
    /**
     *
     *获取当前页面在WMPageController中的index，有一点bug,获取到的index不准确，再等等吧。
     */
    //    WMPageController *pageController = (WMPageController *)self.parentViewController;
    //    NSLog(@"WMPageController当前页面%d",pageController.selectIndex);
    //        NSLog(@"WMPageController当前页面%d",pageController.selectIndex);
    //防止与顶部重叠
    self.tableView.contentInset=UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    //    //指定大标题
    //    mData=[[NSMutableArray alloc]init];
    ////    [mData addObject:[NSString stringWithFormat:@"当前页面%d, 你是最美的",pageController.selectIndex]];
    //    [mData addObject:@"心灵的憩息之地"];
    //    [mData addObject:@"优雅，是一种岁月"];
    //    [mData addObject:@"科学家证实：“3岁看大”确有科学依据"];
    //    [mData addObject:@"人生处世心态好，看淡尘世品行高"];
    //    [mData addObject:@"人生十二最"];
    //    //指定封面
    //    mImg=[[NSMutableArray alloc]init];
    //    [mImg addObject:@"1.jpg"];
    //    [mImg addObject:@"2.jpg"];
    //    [mImg addObject:@"3.jpg"];
    //    [mImg addObject:@"4.jpg"];
    //    [mImg addObject:@"5.jpg"];
    //
    //    //指定作者
    //    mDataAuthor=[[NSMutableArray alloc]init];
    //    [mDataAuthor addObject:@"余秋雨"];
    //    [mDataAuthor addObject:@"老舍"];
    //    [mDataAuthor addObject:@"张凯景"];
    //    [mDataAuthor addObject:@"李非"];
    //    [mDataAuthor addObject:@"张晓静"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 加载文章列表
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
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/cms/article/getList",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  @"channelType":@"zxxx",
                                  @"pageNumber":@"1",
                                  @"token":token
                                  };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        
        //        "data" : [
        //                  {
        //                      "id" : "bb744859cadc4c85b3b5228723da8671",
        //                      "title" : "1",
        //                      "author" : "超级管理员",
        //                      "publishat" : 1484101843,
        //                      "picurl" : "\/schoolCon\/upload\/image\/20170111\/5rpblhora6i7prhqa1i7j48b15.14.02.png"
        //                  }
        //                  ]
        
        
        //        {
        //            "msg" : "ok",
        //            "data" : {
        //                "schools" : [
        //                             {
        //                                 "id" : "pi153odfasd",
        //                                 "name" : "长郡中学",
        //                                 "type" : 0,
        //                                 "hasChildren" : false
        //                             },
        //                             {
        //                                 "id" : "1564do12spa",
        //                                 "name" : "雅礼中学",
        //                                 "type" : 0,
        //                                 "hasChildren" : false
        //                             }
        //                             ]
        //            },
        //            "code" : 0
        //        }
        
        
        if(doc!=nil){
            NSLog(@"*****doc不为空***********");
            if([@"ok" isEqualToString:[doc objectForKey:@"msg"]])
            {
                if(nil!=[doc allKeys]){
                    
                    NSArray *articleArray=[doc objectForKey:@"data"];
                    //            if(data!=nil){
                    //                NSArray *schoolArray=[data objectForKey:@"schools"];
                    for(NSDictionary *item in  articleArray ){
                        Article *model=[[Article alloc]init];
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
                        NSLog(@"addObject之前");
                        [mDataArticle addObject:model];
                        NSLog(@"addObject之后");
                    }
                    NSLog(@"mDataArticle项数为%i",[mDataArticle count]);
                    NSLog(@"//更新界面");
                    //更新界面
                    [mTableView reloadData];
                    //            }
                }
                else
                {
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"抱歉，尚无文章可以阅读" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                               style:UIAlertActionStyleDefault handler:nil];
                    
                    //        信息框添加按键
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            }
            
            else{
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:[doc objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                           style:UIAlertActionStyleDefault handler:nil];
                //        信息框添加按键
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
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
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:errorUser preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }];}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    return [mDataArticle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Vp1TableViewCell *cell = (Vp1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        cell=[[Vp1TableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    ;
    
    Article *model=[mDataArticle objectAtIndex:indexPath.row];
    NSLog(@"cellForRowAtIndexPath");
    
    cell.UILabelTitle.text=model.title;
    NSLog(@"model.title;");
    cell.UILabelTitle.numberOfLines=2;
    /**
     *NSNumber 转成用户看得懂的时间
     */
    NSString *timeStamp2 = model.date.stringValue;
    long long int date1 = (long long int)[timeStamp2 intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date2];
    cell.UILabelDate.text=currentDateString;
    cell.UILabelAuthor.text= model.author;
    [cell.UIImgCover sd_setImageWithURL:[NSString stringWithFormat:@"http://%@:8080%@",myDelegate.ipString,model.picUrl] placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    return cell;
}

#pragma mark 文章点击事件
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [self loadArticleData];
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/sys/user/validateVip",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
    NSDictionary *parameters = @{
                                 //                                 @"id": @"bb744859cadc4c85b3b5228723da8671",
                                 @"appId": @"03a8f0ea6a",
                                 @"appSecret": @"b4a01f5a7dd4416c",
                                 @"token":myDelegate.token
                                 };
    
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *result=[JsonUtil DataTOjsonString:responseObject];
        
        NSLog(@"***************返回结果***********************");
        NSLog(result);
        /**
         *开始解析json
         */
        
        
        
        //
        //        //NSString *result=[self DataTOjsonString:responseObject];
        NSData *data=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=[[NSError alloc]init];
        NSDictionary *doc= [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //        {
        //         "msg" : "激活失败,该账号已经进行过激活",
        //         "code" : 205
        //         }
        NSLog(@"服务器返回msg%@",[doc objectForKey:@"msg"]);
        NSLog(@"服务器返回code%@",[doc objectForKey:@"code"]);
        NSNumber *code=0;
        if([[doc objectForKey:@"msg"] isEqualToString:@"会员"]){
            ArticleDetailViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
            nextPage->pubString=[mData objectAtIndex:indexPath.row];
            nextPage.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:nextPage animated:YES];
        }
        else
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"您不是VIP，无法查看精品文章" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                       style:UIAlertActionStyleDefault handler:nil];
            
            //        信息框添加按键
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:errorUser preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
    //    [self verifyVip];
    
    
    
}
//-(void)verifyVip (NSInteger *){
//
//
//
//
//    //根据storyboard id来获取目标页面
//    ArticleDetailViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
//    //    传值
//    nextPage->pubString=[mData objectAtIndex:indexPath.row];
//    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
//    nextPage.hidesBottomBarWhenPushed=YES;
//
//    //跳转
//    [self.navigationController pushViewController:nextPage animated:YES];
//}

//-(NSString*)DataTOjsonString:(id)object
//{
//    NSString *jsonString = nil;
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
//                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    return jsonString;
//}

#pragma mark
-(void)loadArticleData{
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
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/cms/article/getObject",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
    NSDictionary *parameters = @{
                                 @"id": @"bb744859cadc4c85b3b5228723da8671",
                                 @"appId": @"03a8f0ea6a",
                                 @"appSecret": @"b4a01f5a7dd4416c",
                                 @"token":myDelegate.token
                                 };
    
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        
        NSLog(@"***************返回结果***********************");
        NSLog([JsonUtil DataTOjsonString:responseObject]);
        //        NSLog([self DataTOjsonString:responseObject]);
        //          NSLog([self convertToJsonData:dic]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圆形进度条
        [hud hide:YES];
        NSString *errorUser=[error.userInfo objectForKey:NSLocalizedDescriptionKey];
        if(error.code==-1009)
            errorUser=@"主人，似乎没有网络喔！";
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:errorUser preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}


@end
