//
//  LinkmanTableViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "LinkmanTableViewController.h"
#import "LinkmanTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
#import "LinkMan.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "JsonUtil.h"
#import "MBProgressHUD.h"
#import "Alert.h"
@interface LinkmanTableViewController ()

@end

@implementation LinkmanTableViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataRemark;
    NSMutableArray *mDataAvatar;
    
    NSMutableArray *allDataFromServer;
    
    UITableView *mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allDataFromServer=[[NSMutableArray alloc]init];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       mTableView=tableView;
    return [allDataFromServer count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    LinkmanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[LinkmanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
    cell.UILabelName.text =model.name;
    cell.UILabelRemark.text = model.introduction;
    //    cell.UIImgAvatar.image=[UIImage imageNamed:[mDataAvatar objectAtIndex:indexPath.row]];
    if([@"private" isEqualToString: model.type]){
        [cell.UIImgAvatar sd_setImageWithURL:model.picUrl placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    }
    else
        cell.UIImgAvatar.image=[UIImage imageNamed:@"group.png"];
    cell.UIImgAvatar.layer.masksToBounds = YES;
    cell.UIImgAvatar.layer.cornerRadius = cell.UIImgAvatar.frame.size.height / 2 ;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LinkMan *model=[allDataFromServer objectAtIndex:indexPath.row];
    if([@"private" isEqualToString: model.type]){
        //新建一个聊天会话View Controller对象
        RCConversationViewController *chat = [[RCConversationViewController alloc]init];
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
        chat.conversationType = ConversationType_PRIVATE;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
        chat.targetId =model.LinkmanId;
        //设置聊天会话界面要显示的标题
        chat.title = model.name;
        //设置隐藏底部栏
        chat.hidesBottomBarWhenPushed=YES;
        //显示聊天会话界面
        [self.navigationController pushViewController:chat animated:YES];
    }
    else{
//        LinkMan *group=[[LinkMan alloc]init];
//        group.type=@"group";
//        group.LinkmanId=@"1";
//        group.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
//        group.name=@"初二3班班群";
//        group.introduction=@"";
        NSLog(@"群聊");
        //新建一个聊天会话View Controller对象
        RCConversationViewController *chat = [[RCConversationViewController alloc]init];
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
        chat.conversationType = ConversationType_GROUP;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
        chat.targetId = model.LinkmanId;
        //设置聊天会话界面要显示的标题
        chat.title = model.name;
        //设置隐藏底部栏
        chat.hidesBottomBarWhenPushed=YES;
        //显示聊天会话界面
        [self.navigationController pushViewController:chat animated:YES];
    }
}
#pragma mark 加载联系人列表
-(void)loadData {
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.color = [UIColor colorWithHexString:@"343637" alpha:0.5];
    hud.labelText = @" 获取数据...";
    [hud show:YES];
    //获取全局ip地址
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSString *urlString;
    
    urlString= [NSString stringWithFormat:@"%@/api/sys/user/contacts",myDelegate.ipString];

    
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    NSString *token=myDelegate.token;
    // 请求参数
    NSDictionary *parameters = @{ @"appId":@"03a8f0ea6a",
                                  @"appSecret":@"b4a01f5a7dd4416c",
                                  
                                  //@"pageNumber":[NSString stringWithFormat:@"%d",pageIndex],
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
                    
                    NSArray *array=[doc objectForKey:@"data"];
                    if(0==[array count]){
                        [Alert showMessageAlert:@"抱歉,没有数据" view:self];
                    }
                    else{
                        //单聊联系人信息
                        NSArray *contactsArray=[[doc objectForKey:@"data"] objectForKey:@"contacts"];
                       for(NSDictionary *item in  contactsArray ){
                            LinkMan *model=[[LinkMan alloc]init];
                            model.LinkmanId=item [@"userId"];
                            //model.picUrl=item [@"picurl"];
                            model.introduction=item [@"remark"];
                            model.name=item [@"name"];
                            model.type= @"private";
                            [allDataFromServer addObject:model];
                        }
                        //群聊联系人信息
                        NSArray *groupsArray=[[doc objectForKey:@"data"] objectForKey:@"groups"];
                        for(NSDictionary *item in  groupsArray ){
                            LinkMan *model=[[LinkMan alloc]init];
                            model.LinkmanId=item [@"id"];
                            //model.picUrl=item [@"picurl"];
                            model.name=item [@"name"];
                            [allDataFromServer addObject:model];
                        }
                        NSLog(@"allDataFromServer项数为%i",[allDataFromServer count]);
                        NSLog(@"//更新界面");
                        //更新界面
                        [mTableView reloadData];
                    }
                    //            }
                }
                else
                {
                    [Alert showMessageAlert:@"抱歉，尚无文章可以阅读" view:self];
                }
            }
            
            else{
                [Alert showMessageAlert:[doc objectForKey:@"msg"]  view:self];
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
