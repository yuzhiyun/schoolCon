//
//  ArticleDetailViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "CommentTableViewCell.h"
#import "AppDelegate.h"
#import "Toast.h"
@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataCommentContent;
    
    
}

@synthesize UIWebViewArticle;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=title;
    //处理软键盘遮挡输入框事件
    _mUITextFieldCommnet.delegate=self;
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    
    [rightButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=rightButton;

    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString: urlString];

    

    NSString *body = [NSString stringWithFormat: @"id=%@&token=%@&appId=%@&appSecret=%@", articleId,myDelegate.token,myDelegate.appId,myDelegate.appSecret];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [UIWebViewArticle loadRequest: request];

}
- (IBAction)sendComment:(id)sender {
    
    if(0==_mUITextFieldCommnet.text.length){
        //输入框没有获取焦点的时候（点击软键盘的“完成”，就会失去焦点），可以弹出Toast，但是获取焦点后，弹不出 toast
        [Toast showToast:@"评论不能为空" view:self.view];
        NSLog(@"显示toast");
    }
    NSLog(_mUITextFieldCommnet.text);
    NSLog(@"%d",_mUITextFieldCommnet.text.length);
    
}


/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    
    NSLog(@"收藏");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //    self.title=pubString;
    // Dispose of any resources that can be recreated.
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y +frame.size.height - (self.view.frame.size.height - 270);//键盘高度270
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
@end
