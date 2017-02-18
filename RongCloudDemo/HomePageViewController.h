//
//  HomePageViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/15.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
@interface HomePageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,CycleScrollViewDelegate,CycleScrollViewDatasource>
// 这个view 只是用于确定轮播图的高度，因为轮播图在代码中创建，而其他的view 的位置与他相关，于是用一个view顶替轮播图的位置
@property (weak, nonatomic) IBOutlet UIView *mUIViewContainer;
//当用户是老师的时候，不能显示这个按钮和label
//@property (weak, nonatomic) IBOutlet UIButton *mUIButtonVip;
//@property (weak, nonatomic) IBOutlet UILabel *mUILabelVip;
@property (weak, nonatomic) IBOutlet UIButton *mUIButtonVip;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelVip;



@end
