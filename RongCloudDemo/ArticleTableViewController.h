//
//  Vp1TableViewController.h
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/17.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewController : UITableViewController{

    
    NSMutableArray *mData;
     NSMutableArray *mDataAuthor;
    NSMutableArray *mImg;
    @public 
    NSMutableArray *title;
    
    @public NSInteger index;
    
    
    /**这个参数用于判断页面类型
     1,  在线学习---------------zxxx
     2,  心理知识---------------xlzs
     3，我的文章-在线学习---------myzxxx
     4，我的文章-心理知识---------myxlzs
     5，我的文章----------my(就是说收藏就不分在线学习和心理知识)
     */
@public
    NSString *type;
        
    
}

@end
