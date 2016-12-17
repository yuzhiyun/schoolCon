//
//  CommentTableViewCell.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *UILabelDate;
@property (weak, nonatomic) IBOutlet UIImageView *UIImgAvarta;
@property (weak, nonatomic) IBOutlet UILabel *UILabelCommentContent;
@property (weak, nonatomic) IBOutlet UILabel *UILabelUsername;

@end
