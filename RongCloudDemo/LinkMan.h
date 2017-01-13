//
//  LinkMan.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/13.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  LinkMan:NSObject
//type判断是单个人还是群组
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *LinkmanId;
@property (nonatomic,copy)NSString *picUrl;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *introduction;

@end

