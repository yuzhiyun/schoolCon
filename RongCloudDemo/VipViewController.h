//
//  VipViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

}
@property (weak, nonatomic) IBOutlet  UILabel *mUILabelExpireDate;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelExpireDaysNum;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelWelcome;

//+(void) getVipInfo;

@end
