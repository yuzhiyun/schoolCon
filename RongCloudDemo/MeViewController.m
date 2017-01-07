//
//  MeViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "EntranceViewController.h"
#import "ArticleTableViewController.h"
@interface MeViewController (){
    
    NSMutableArray *mDataKey;
    NSMutableArray *mDataImg;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *UIImageViewAvatar;


@end

@implementation MeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"我的收藏";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:121/255.0 blue:251/255.0 alpha:1.0]];
    //      navigationBar标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    

    //    隐藏返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=YES;
    
    
    //    返回箭头和文字的颜色，只要写一次就行了，是全局的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    修改下一个界面返回按钮的title，注意这行代码每个页面都要写一遍，不是全局的
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    mDataKey=[[NSMutableArray alloc]init];
    
    [mDataKey addObject:@"修改电话"];
    [mDataKey addObject:@"我的活动"];
    [mDataKey addObject:@"我的测试"];
    [mDataKey addObject:@"我的会员"];
    [mDataKey addObject:@"我的收藏"];
    [mDataKey addObject:@"退出登录"];
    
    mDataImg=[[NSMutableArray alloc]init];
    [mDataImg addObject:@"phone.png"];
    [mDataImg addObject:@"coffee_little.png"];
    [mDataImg addObject:@"test_litttle.png"];
    
    [mDataImg addObject:@"vip.png"];
    
    [mDataImg addObject:@"callect.png"];
    [mDataImg addObject:@"exit.png"];
    
    
    
    //    加载图片,如果加载不到图片，就显示favorites.png
    [self.UIImageViewAvatar sd_setImageWithURL:@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg" placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    //设置图片为圆形
    /*
     *View都有一个layer的属性，我们正是通过layer的一些设置来达到圆角的目的，因此诸如UIImageView、UIButton
     *UILabel等view都可以设置相应的圆角。对于圆形的头像，要制作正圆，我们需要首先设置UIImageView的高宽的一致
     *的，然后我们设置其圆角角度为高度除以2即可，相当于90度
     * http://blog.csdn.net/cloudox_/article/details/50511531
     */
    self.UIImageViewAvatar.layer.masksToBounds = YES;
    self.UIImageViewAvatar.layer.cornerRadius = self.UIImageViewAvatar.frame.size.height / 2 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [mDataKey count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"inforCell";
    
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.UILabelKey.text=[mDataKey objectAtIndex:indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:[mDataImg objectAtIndex:indexPath.row]];
    
    
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断是不是退出登录
    if([mDataKey count]-1==indexPath.row){
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"确定退出吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确认"
                                                   style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                       
//                                                       NSLog(@"退出登录");
                                                       
                                                           
                                                           //根据storyboard id来获取目标页面
                                                           EntranceViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"EntranceViewController"];
                                                        nextPage.hidesBottomBarWhenPushed=YES;
                                                           //跳转
                                                           [self.navigationController pushViewController:nextPage animated:YES];
                                                       
                                                       
                                                       
                                                   }];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                           
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        
        
        
//        信息框添加按键
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    //我的收藏
    
    if(4==indexPath.row){
        //显示顶部导航
        self.navigationController.navigationBarHidden=NO;
        ArticleTableViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleTableViewController"];
        nextPage.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:nextPage animated:YES];
        
    }
    
    
    
}
//虽然viewDidLoad已经设置了隐藏，但是在进入下一个页面并返回此页面的时候，还是会出现，所以在这里再次隐藏
-(void) viewDidAppear:(BOOL)animated{
    //    隐藏返回按钮navigationController的navigationBar
    self.navigationController.navigationBarHidden=YES;
}


@end
