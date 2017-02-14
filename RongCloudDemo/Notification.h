//
//  Notification.h
//  SchoolCon
//
//  Created by 秦启飞 on 2017/2/10.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  Notification:NSObject

@property (nonatomic,copy)NSString *articleId;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *publishat;
@property (nonatomic,copy)NSNumber *type;

@end
