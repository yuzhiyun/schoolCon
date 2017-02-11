//
//  ArticleDetailViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@interface ArticleDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>{
    
    
@public
    NSString *articleId;
@public
    NSString *title;
    
@public
    NSString *pubString;
@public
    NSString *urlString;
    
@public
    Article *article;
}
@property (weak, nonatomic) IBOutlet UIWebView *UIWebViewArticle;

@property (weak, nonatomic) IBOutlet UITextField *mUITextFieldCommnet;
@end
