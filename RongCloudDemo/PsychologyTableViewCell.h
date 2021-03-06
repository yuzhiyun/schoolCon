//
//  TemplateTableViewCell.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/18.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PsychologyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *UILabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *UILabelPrice;
@property (weak, nonatomic) IBOutlet UILabel *UILabelNumOfTest;
@property (weak, nonatomic) IBOutlet UIImageView *UIImageViewCover;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelPriceKey;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelTestNumKey;

@end
