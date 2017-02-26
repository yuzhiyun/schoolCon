//
//  Activity.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/12.
//  Copyright © 2017年 dlz. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface  Activity:NSObject
@property (nonatomic,copy)NSString *activityId;
@property (nonatomic,copy)NSString *picUrl;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *publisher;
@property (nonatomic,copy)NSString *place;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *tel;

@property (nonatomic,copy)NSNumber *NSNumprice;

//@property (nonatomic,copy)NSString *price;

@end
