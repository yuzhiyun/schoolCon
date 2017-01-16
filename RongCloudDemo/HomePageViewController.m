//
//  HomePageViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/15.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "HomePageViewController.h"
#import "NotificationTableViewController.h"
#import "DetailNotificationViewController.h"
//#import "PsychologyListTableViewController.h"
#import "QueryGradeTableViewController.h"
#import "PhysicalViewController.h"
//#import "DetailNotificationViewController.h"
#import "TeacherViewController.h"
#import "TeacherNotUseCollectionViewController.h"
#import "RotateImgArticleViewController.h"
#import "CycleScrollView.h"
#import "SchoolMomentsTableViewController.h"
#import "PsychologyTableViewController.h"
#import "VipViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
#import "LinkMan.h"
#import "ChooseYearViewController.h"
@interface HomePageViewController ()
//轮播图组件
@property (nonatomic, strong) CycleScrollView *scrollView;
//轮播图图片
@property (nonatomic, strong) NSArray *imageArray;
//轮播图对应 的文章URL
@property (nonatomic, strong) NSArray *articleUrlArray;
@end

@implementation HomePageViewController{

    NSMutableArray *recipes;

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.title=@"首页";
//    navigationBar背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
//      navigationBar标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];

    //    返回箭头和文字的颜色，只要写一次就行了，是全局的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    /**
     *添加轮播图组件
     */
    _imageArray = @[@"1",@"2",@"3",@"4"];
    
_articleUrlArray=@[@"http://mp.weixin.qq.com/s/m3y2dvyWLxHoFskyX5aWPQ",@"http://mp.weixin.qq.com/s/m3y2dvyWLxHoFskyX5aWPQ",@"http://mp.weixin.qq.com/s/m3y2dvyWLxHoFskyX5aWPQ",@"http://mp.weixin.qq.com/s/m3y2dvyWLxHoFskyX5aWPQ"];
    _scrollView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height, [[UIScreen mainScreen]bounds].size.width , _mUIViewContainer.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.datasource = self;
    _scrollView.animationDuration = 4;
    [self.view addSubview:_scrollView];


    recipes=[[NSMutableArray alloc]init];
    
    [recipes addObject:@"明天开运动会"];
    [recipes addObject:@"系统升级，明早恢复"];
    [recipes addObject:@"今晚不用上课"];
//    recipes = [NSArray arrayWithObjects:@"Egg Benedict",@"Ham and Cheese Panini","yuzhiyun",nil];
    // Do any additional setup after loading the view.
}
//轮播图数量
- (NSInteger)numberOfPages
{
    return _imageArray.count;
}
//指定具体图片
- (UIView *)pageAtIndex:(NSInteger)index size:(CGSize)size
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width , _scrollView.frame.size.height)];
    imageView.image = [UIImage imageNamed:_imageArray[index]];
    return imageView;
}
//轮播图点击事件
- (void)scrollView:(CycleScrollView *)scrollView didClickPage:(UIView *)view atIndex:(NSInteger)index
{
    NSLog(@"你点的是第%d个",(int)index + 1);

    RotateImgArticleViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"RotateImgArticleViewController"];
    //    传值
    nextPage->url=[_articleUrlArray objectAtIndex:index];
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)classGroup:(id)sender {
    
    LinkMan *group=[[LinkMan alloc]init];
    group.type=@"group";
    group.LinkmanId=@"1";
    group.picUrl=@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
    group.name=@"初二3班班群";
    group.introduction=@"";
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_GROUP;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = group.LinkmanId;
    //设置聊天会话界面要显示的标题
    chat.title = group.name;
    //设置隐藏底部栏
    chat.hidesBottomBarWhenPushed=YES;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}


//跳转到所有通知页面
- (IBAction)btnEnterAllNotifications:(id)sender {
    //根据storyboard id来获取目标页面
    NotificationTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationTableViewController"];
//    传值
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
        [self.navigationController pushViewController:nextPage animated:YES];
}
//跳转到心理测评
- (IBAction)btnEnterPsychology:(id)sender {
    //根据storyboard id来获取目标页面
    PhysicalViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"PhysicalViewController"];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)vip:(id)sender {
    VipViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"VipViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
    
}



- (IBAction)schoolMoments:(id)sender {
    SchoolMomentsTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"SchoolMomentsTableViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}


- (IBAction)physicalTest:(id)sender {
    
    
    PsychologyTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"PsychologyTableViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
}

- (IBAction)enterQueryGrade:(id)sender {
//    弹出对话框选择年级
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"请选择年级"
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"2016学年", @"2015学年",@"2014学年",nil];
//    actionSheet.actionSheetStyle = UIBarStyleDefault;
//    [actionSheet showInView:self.view];
     ChooseYearViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseYearViewController"];
    nextPage.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
}

//UIActionSheet对话框选择监听事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"选择年级对话框监听事件,您选择了%i",buttonIndex);
        QueryGradeTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"QueryGradeTableViewController"];
    
        //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
        nextPage.hidesBottomBarWhenPushed=YES;
    
        //跳转
        [self.navigationController pushViewController:nextPage animated:YES];
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.imageView.image=[UIImage imageNamed:@"notice1.png"];
    cell.detailTextLabel.text=@"2017/12/21";
//    cell.tes
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //根据storyboard id来获取目标页面
    DetailNotificationViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationViewController"];
    
    
    //    传值
    nextPage->pubString=[recipes objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
    
    
    
    
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    
//    [[segue destinationViewController] setMDetailString: @"传值过去"];
//    
//    NSLog(@"能跳转吗？prepareForSegue");
//    
//    
//    
//    
//    
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
