//
//  TEST1Controller.m
//  AlwayScrollingView
//
//  Created by tianshikechuang on 16/4/21.
//  Copyright © 2016年 zxw. All rights reserved.
//

#import "TEST1Controller.h"
#import "AlwayScrollerView.h"

@interface TEST1Controller ()

@end

@implementation TEST1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无限滚动";
    self.view.backgroundColor = [UIColor lightGrayColor];
    

////////////////////////////////////////////////////////////////////
////
////如果控制器本身有导航栏，就不要让AlwayScrollerView成为控制器的第一个视图！！！！
////
/////////////////////////////////////////////////////////////////////
    UIView *firstSubView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:firstSubView];
    
    NSArray * arr = @[@"1.png",@"2.png",@"3.png",@"4.png",@"5.png"];
    AlwayScrollerView *scroller = [AlwayScrollerView alwayScrollerViewWithImgNameArr:arr frame:CGRectMake(0, 64, 415, 300)];
    [scroller autoAnimetionTimeInterval:3];
    [scroller setIsHidenPageController:NO];
    [self.view addSubview:scroller];
 
}



@end
