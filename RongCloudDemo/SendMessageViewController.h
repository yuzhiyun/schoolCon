//
//  SendMessageViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2017/1/14.
//  Copyright © 2017年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageViewController : UIViewController{
    
    @public
    NSMutableArray *dataSelectedLinkman;

    
}
@property (weak, nonatomic) IBOutlet UILabel *UILabelNumber;
@property (weak, nonatomic) IBOutlet UILabel *UILabelReceiver;
@property (weak, nonatomic) IBOutlet UITextView *UITextViewMessage;

@end
