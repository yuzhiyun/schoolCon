//
//  TeacherNotUseCollectionViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/23.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherNotUseCollectionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
@public NSString *mExamId;
@public NSString *mStudentId;
@public NSString *type;
}
@property (weak, nonatomic) IBOutlet UILabel *mUILabelTotal;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelCmean;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelCrank;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelGmean;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelGrank;


@end
