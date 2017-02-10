//
//  MeViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mUILabelKeyStudentName;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelKeySchool;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelKeyClass;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelKeyHeadTeacher;



@property (weak, nonatomic) IBOutlet UILabel *mUILabelUname;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelStudentName;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelSchool;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelClass;
@property (weak, nonatomic) IBOutlet UILabel *mUILabelHeadTeacher;



@end
