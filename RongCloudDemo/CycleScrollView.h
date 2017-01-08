//
//  CycleScrollView.h
//  CycleScrollView
//
//  Created by tom.sun on 16/6/1.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CycleScrollViewDelegate;
@protocol CycleScrollViewDatasource;
@interface CycleScrollView : UIView
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSTimeInterval animationDuration;
/** datasource */
@property (nonatomic,weak,setter = setDataource:) id<CycleScrollViewDatasource> datasource;
/** delegate */
@property (nonatomic,weak,setter = setDelegate:) id<CycleScrollViewDelegate> delegate;

- (void)reloadData;
@end

@protocol CycleScrollViewDelegate <NSObject>
/*!
 *  @brief  点击scroolView当前视图的事件
 *
 *  @param scrollView 当前类
 *  @param view       选中视图
 *  @param index      选中页码
 */
- (void)scrollView:(CycleScrollView *)scrollView didClickPage:(UIView *)view atIndex:(NSInteger)index;
@end

@protocol CycleScrollViewDatasource <NSObject>
/*!
 *  @brief  返回总页面数码
 *
 *  @return 总页面数码
 */
- (NSInteger)numberOfPages;

/*!
 *  @brief  返回每一个页面的UIView
 *
 *  @param index 当前index
 *  @param size  当前页面的size
 *
 *  @return UIView
 */
- (UIView *)pageAtIndex:(NSInteger)index size:(CGSize)size;
@end