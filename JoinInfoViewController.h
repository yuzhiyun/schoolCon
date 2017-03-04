//
//  JoinInfoViewController.h
//  SchoolCon
//
//  Created by 秦启飞 on 2017/3/2.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinInfoViewController : UIViewController{
    @public NSString *myActivityOrderId;
}
@property (weak, nonatomic) IBOutlet UILabel *mUILabelTitle;

@property (weak, nonatomic) IBOutlet UILabel *mUILabelPublisher;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelDate;

@property (weak, nonatomic) IBOutlet UILabel *mUILabelPlace;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelPubPhone;

@property (weak, nonatomic) IBOutlet UILabel *mUILabelName;

@property (weak, nonatomic) IBOutlet UILabel *mUILabelPhone;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelJoinNumber;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelFee;

@end
