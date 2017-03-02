//
//  VipViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/8.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
@public NSString *avatarImgUrl;

}


@property (weak, nonatomic) IBOutlet UIImageView *mUIImageViewAvatar;

@property (weak, nonatomic) IBOutlet  UILabel *mUILabelExpireDate;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelExpireDaysNum;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelWelcome;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelIsVip;
@property (weak, nonatomic) IBOutlet UIImageView *mUIImageViewIsVip;

//+(void) getVipInfo;
-(void) getVipInfo;
@end
