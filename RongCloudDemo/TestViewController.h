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

@public
    NSString *pubString;
@public
    NSString *testId;
@public
    NSString *testName;
@public
    NSString *picUrl;
}
@end
