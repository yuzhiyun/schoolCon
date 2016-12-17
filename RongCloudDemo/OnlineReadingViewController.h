//
//  OnlineReadingViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>
//导入viewpager的库
//http://blog.csdn.net/yubo_725/article/details/51159633
#import "WMPageController.h"
@interface OnlineReadingViewController :  WMPageController

#pragma mark 标题数组
@property (strong, nonatomic) NSArray *titles;
@end
