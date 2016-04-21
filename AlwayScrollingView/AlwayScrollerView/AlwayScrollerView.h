//
//  AlwayScrollerView.h
//  AlwayScrollingView
//
//  Created by lushouxiang on 15/12/24.
//  Copyright © 2015年 zxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlwayScrollerView : UIView

@property (nonatomic ,assign) BOOL isHidenPageController;


/**
 *  根据图片名 - 实例化对象
 *
 *  @param imageArr 图片数组
 *  @param frame    视图的frame
 *
 */
+ (instancetype)alwayScrollerViewWithImgNameArr:(NSArray *)imageArr frame:(CGRect)frame;


/**
 *  根据图片 - 实例化对象
 *
 *  @param imageArr 图片数组
 *  @param frame    视图的frame
 */
+ (instancetype)alwayScrollerViewWithImageArr:(NSArray *)imageArr frame:(CGRect)frame;



- (void)autoAnimetionTimeInterval:(NSTimeInterval)time;


@end
