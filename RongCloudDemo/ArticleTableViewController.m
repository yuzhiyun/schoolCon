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
//#import "AppDelegate.h"
#import "WMPageController.h"

#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface ArticleTableViewController ()

@end

@implementation ArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    /**
      *
      *获取当前页面在WMPageController中的index，有一点bug,获取到的index不准确，再等等吧。
      */
//    WMPageController *pageController = (WMPageController *)self.parentViewController;
//    NSLog(@"WMPageController当前页面%d",pageController.selectIndex);
//        NSLog(@"WMPageController当前页面%d",pageController.selectIndex);
    //防止与顶部重叠
    self.tableView.contentInset=UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    //指定大标题
    mData=[[NSMutableArray alloc]init];
//    [mData addObject:[NSString stringWithFormat:@"当前页面%d, 你是最美的",pageController.selectIndex]];
    [mData addObject:@"心灵的憩息之地"];
    [mData addObject:@"优雅，是一种岁月"];
    [mData addObject:@"科学家证实：“3岁看大”确有科学依据"];
    [mData addObject:@"人生处世心态好，看淡尘世品行高"];
    [mData addObject:@"人生十二最"];
    //指定封面
    mImg=[[NSMutableArray alloc]init];
    [mImg addObject:@"1.jpg"];
    [mImg addObject:@"2.jpg"];
    [mImg addObject:@"3.jpg"];
    [mImg addObject:@"4.jpg"];
    [mImg addObject:@"5.jpg"];
    
    //指定作者
    mDataAuthor=[[NSMutableArray alloc]init];
    [mDataAuthor addObject:@"余秋雨"];
    [mDataAuthor addObject:@"老舍"];
    [mDataAuthor addObject:@"张凯景"];
    [mDataAuthor addObject:@"李非"];
    [mDataAuthor addObject:@"张晓静"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *urlString= [NSString stringWithFormat:@"http://%@:8080/schoolCon/api/cms/article/getList",myDelegate.ipString];
    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    /*
     第一个参数：请求的地址
     第二个参数：需要传给服务端的参数
     第三个参数：数据请求成功回调的block >>>成功后的数据：responseObject
     第四个参数：数据请求失败回调的block >>>失败后的原因：error
     */
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"channelType":@"zxxx",
                                 @"pageNumber":@"1"
                                 };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        
        NSLog(@"***************返回结果***********************");
        NSLog([self DataTOjsonString:responseObject]);
        //        NSLog([self DataTOjsonString:responseObject]);
        //          NSLog([self convertToJsonData:dic]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏圆形进度条
        [hud hide:YES];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"访问错误%@",error]preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"访问错误%@",error);
    }];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [mData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Vp1TableViewCell *cell = (Vp1TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        cell=[[Vp1TableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    ;
    NSString *t1=[mData objectAtIndex:indexPath.row];
//    NSString *t1=[myDelegate.title objectAtIndex:indexPath.row];
    
//    int a=[myDelegate.onlineReadinngTitle count];
//    NSLog(@"title的大小为**************%i",a);
    
        cell.UILabelTitle.text=t1;
    cell.UILabelTitle.numberOfLines=2;
    
//    cell.UILabelDate.text=@"2016-12-27，页面index";
    int a=index;
    //cell.UILabelDate.text=[NSString stringWithFormat:@"页索引=%d",a];
    cell.UILabelDate.text=@"2016-12-27";
    cell.UILabelAuthor.text=[mDataAuthor objectAtIndex:indexPath.row];

    cell.UIImgCover.image=[UIImage imageNamed:[mImg objectAtIndex:indexPath.row]];
//    cell.UIImgCover.image=[UIImage imageNamed:@"study.jpg"];
    
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    [self loadArticleData];
    
    //根据storyboard id来获取目标页面
    ArticleDetailViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailViewController"];
    
    //    传值
    nextPage->pubString=[mData objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}

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

#pragma mark 请求数据
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
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    // 请求参数
    NSDictionary *parameters = @{
//                                 @"channelType":@"zxxx",
//                                 @"pageNumber":@"1",
                                 @"id":@"bb744859cadc4c85b3b5228723da8671"
                                 };
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //隐藏圆形进度条
        [hud hide:YES];
        
        NSLog(@"***************返回结果***********************");
        NSLog([self DataTOjsonString:responseObject]);
        //        NSLog([self DataTOjsonString:responseObject]);
        //          NSLog([self convertToJsonData:dic]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏圆形进度条
        [hud hide:YES];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"访问错误%@",error]preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:nil];
        
        //        信息框添加按键
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"访问错误%@",error);
    }];
}


@end
