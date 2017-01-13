//
//  MessageViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
@interface MessageViewController :ChatListViewController<RCIMUserInfoDataSource>

@end
