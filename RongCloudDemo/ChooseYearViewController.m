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
@interface ChooseYearViewController ()
@property (nonatomic, strong) CCZTableButton *tableButton;
@end

@implementation ChooseYearViewController{

    NSMutableArray *mDataExam;

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
    if(buttonIndex!=[grade count])
        
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
    
    
    
    //根据storyboard id来获取目标页面
    ParentsViewController *nextPage= [self.storyboard instantiateViewControllerWithIdentifier:@"ParentsViewController"];
    
    //    传值
//    nextPage->pubString=[recipes objectAtIndex:indexPath.row];
    //UITabBarController和的UINavigationController结合使用,进入新的页面的时候，隐藏主页tabbarController的底部栏
    nextPage.hidesBottomBarWhenPushed=YES;
    
    //跳转
    [self.navigationController pushViewController:nextPage animated:YES];
}


@end
