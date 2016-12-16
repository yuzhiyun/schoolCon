//
//  MeViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "MeViewController.h"
//#import "MeInforTableViewCell.h"
@interface MeViewController (){
    
    NSMutableArray *mKeyInfor;
    NSMutableArray *mValueInfor;
    
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mKeyInfor=[[NSMutableArray alloc]init];
    [mKeyInfor addObject:@"孩子"];
    [mKeyInfor addObject:@"学校"];
    [mKeyInfor addObject:@"班级"];
    [mKeyInfor addObject:@"班主任姓名"];
    [mKeyInfor addObject:@"修改电话"];

    mValueInfor=[[NSMutableArray alloc]init];
    [mValueInfor addObject:@"俞志云"];
    [mValueInfor addObject:@"中南大学"];
    [mValueInfor addObject:@"1404班"];
    [mValueInfor addObject:@"刘名阳"];
    [mValueInfor addObject:@">>>>>"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
         // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [mValueInfor count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text=[mValueInfor objectAtIndex:indexPath.row];
//    cell.keyUILabel.text=[mKeyInfor objectAtIndex:indexPath.row];
//    cell.valueUILabel.text=[mValueInfor objectAtIndex:indexPath.row];
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
