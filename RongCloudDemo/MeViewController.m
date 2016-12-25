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
@interface MeViewController (){
    
    NSMutableArray *mDataKey;
     NSMutableArray *mDataImg;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *UIImageViewAvatar;


@end

@implementation MeViewController


//-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//   
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    mDataKey=[[NSMutableArray alloc]init];

    [mDataKey addObject:@"修改电话"];
    [mDataKey addObject:@"我的活动"];
    [mDataKey addObject:@"我的测试"];
    [mDataKey addObject:@"我的会员"];
    [mDataKey addObject:@"我的收藏"];
    [mDataKey addObject:@"退出登录"];

    mDataImg=[[NSMutableArray alloc]init];
    [mDataImg addObject:@"phone.png"];
    [mDataImg addObject:@"phone.png"];
    [mDataImg addObject:@"phone.png"];

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




@end
