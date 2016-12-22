//
//  TestViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    
    __weak IBOutlet UILabel *UILabelTitle;
//    NSMutableArray *mData;
    int indexOfExercise;
    
//    NSMutableArray *mTitle;
//    NSMutableArray *mItem1;
//    NSMutableArray *mItem2;
//    NSMutableArray *mItem3;
//    NSMutableArray *mItem4;
//    
    NSMutableArray *mAllData;
    UITableView *mTableView;
    
@public
    NSString *pubString;
    
    
}
@end
