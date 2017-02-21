//
//  StudentRank.h
//  SchoolCon
//
//  Created by 秦启飞 on 2017/2/20.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  StudentRank:NSObject

//不知道什么鬼
@property (nonatomic,copy)NSString *gradeId;
//学号
@property (nonatomic,copy)NSString *studentId;

@property (nonatomic,copy)NSString *name;
//班级排名
@property (nonatomic,copy)NSString *crank;
//年级排名
@property (nonatomic,copy)NSString *grank;
@end
