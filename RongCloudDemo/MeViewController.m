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
     NSMutableArray *mDataValue;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *UIImageViewAvatar;


@end

@implementation MeViewController


//-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//   
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    mDataKey=[[NSMutableArray alloc]init];
    [mDataKey addObject:@"孩子姓名（老师端不显示）"];
    [mDataKey addObject:@"学校"];
    [mDataKey addObject:@"班级"];
    [mDataKey addObject:@"班主任姓名（老师端不显示）"];
    [mDataKey addObject:@"修改电话"];
    [mDataKey addObject:@"我的活动"];
    [mDataKey addObject:@"我的心理测评"];
    [mDataKey addObject:@"我的会员"];
    
    mDataValue=[[NSMutableArray alloc]init];
    [mDataValue addObject:@"俞志云"];
    [mDataValue addObject:@"中南大学"];
    [mDataValue addObject:@"1404"];
    [mDataValue addObject:@"刘名阳"];
    [mDataValue addObject:@"》》》》"];
    [mDataValue addObject:@"》》》》"];
    [mDataValue addObject:@"》》》》"];
    [mDataValue addObject:@"》》》》"];

//    #import "UIImageView+WebCache.h"
//    加载图片,如果加载不到图片，就显示favorites.png
 [self.UIImageViewAvatar sd_setImageWithURL:@"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg" placeholderImage:[UIImage imageNamed:@"favorites.png"]];
    // Do any additional setup after loading the view.
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
    cell.UILabelValue.text=[mDataValue objectAtIndex:indexPath.row];
//
//    cell.textLabel.text =     return cell;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
