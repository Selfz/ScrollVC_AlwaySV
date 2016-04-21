//
//  ScrollerVC.h
//  AlwayScrollingView
//
//  Created by tianshikechuang on 16/4/21.
//  Copyright © 2016年 zxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollerVC : UIViewController

@property(nonatomic, assign) CGFloat minheadTitleWidth;
@property(nonatomic, assign) CGFloat headTitleHeight;
@property(nonatomic, assign) int count;
@property(nonatomic, assign) BOOL isTabBar;                 //控制器是否会有TabBar


@property(nonatomic, strong) NSArray * headTitleArr;
@property(nonatomic, strong) NSArray * BodyVCArr;




@end
