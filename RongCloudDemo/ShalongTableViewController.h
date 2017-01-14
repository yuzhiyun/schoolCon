//
//  ShalongTableViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShalongTableViewController : UITableViewController{
    
    
//    NSMutableArray *mData;
//    NSMutableArray *mImg;
/**这个参数用于判断页面类型
 1,  岳麓沙龙---------------ylsl
 2,  心理活动---------------xlhd
 3，我的活动-岳麓沙龙---------myylsl
 4，我的活动-心理活动---------myxlhd
*/
    @public
    NSString *type;
    
}

@end
