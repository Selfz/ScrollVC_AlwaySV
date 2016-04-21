//
//  ScrollerVC.m
//  AlwayScrollingView
//
//  Created by tianshikechuang on 16/4/21.
//  Copyright © 2016年 zxw. All rights reserved.
//

#import "ScrollerVC.h"

@interface ScrollerVC ()<UIScrollViewDelegate>

@property(nonatomic, assign) int currentIndex;

@property(nonatomic, strong) UIScrollView * headScrollView;
@property(nonatomic, strong) UIScrollView * bodyScrollView;


@property(nonatomic, weak) UIButton * headBt;
@property(nonatomic, strong) UIView * headLine;


@end

@implementation ScrollerVC


- (instancetype)init{
    
    if (self = [super init]) {
        self.title = @"滑动控制器";
        self.view.backgroundColor = [UIColor whiteColor];
        UIView *firstSubView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:firstSubView];
    }
    return self;
}

- (void)viewWillLayoutSubviews{
    
    [self layoutHeadScrollView];
    
    [self layoutBodyScrollView];
    
}



- (void)layoutHeadScrollView{
    self.headScrollView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, self.headTitleHeight);
    
    if (self.minheadTitleWidth * self.count > self.view.bounds.size.width) {
        self.headScrollView.contentSize = CGSizeMake(self.minheadTitleWidth * self.count, self.headTitleHeight);
    }else{
        self.minheadTitleWidth = self.view.bounds.size.width / self.count;
        self.headScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.headTitleHeight);
    }
    
    for (int i = 0; i < self.count; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * self.minheadTitleWidth, 0, self.minheadTitleWidth - 1, self.headTitleHeight - 1)];
        button.tag = 1000 + i;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.shadowColor = [UIColor grayColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(1, 1);
        [button setTitle:self.headTitleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.98 green:0.11 blue:0.11 alpha:1] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(headBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:button];
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, self.headTitleHeight - 4, self.minheadTitleWidth,4)];
    view.backgroundColor = [UIColor colorWithRed:0.98 green:0.11 blue:0.11 alpha:1];
    [self.headScrollView addSubview:view];
    self.headLine = view;
    
}


- (UIScrollView *)headScrollView{
    if (!_headScrollView) {
        _headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.headTitleHeight)];
        _headScrollView.bounces = NO;
        _headScrollView.showsHorizontalScrollIndicator = NO;
        _headScrollView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_headScrollView];
    }
    return _headScrollView;
}



- (void)headBtAction:(UIButton *)sender{
    self.headBt.selected = NO;
    self.headBt = sender;
    self.headBt.selected = YES;

    CGFloat x = sender.frame.origin.x;
    
    self.currentIndex = (int)sender.tag - 1000;
    CGFloat ViewWidth = [UIScreen mainScreen].bounds.size.width;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.headLine.frame = CGRectMake(x, self.headTitleHeight - 4, self.minheadTitleWidth,4);
        [self.bodyScrollView setContentOffset:CGPointMake(self.currentIndex * ViewWidth, 0)];
    }];
}





- (void)layoutBodyScrollView{
    CGFloat Y = 64 + self.headTitleHeight;
    CGFloat ViewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat heigth = viewHeight - Y - (self.isTabBar?49:0);
    
    self.bodyScrollView.frame = CGRectMake(0, Y, ViewWidth,heigth);
    self.bodyScrollView.contentSize = CGSizeMake(self.count * ViewWidth, viewHeight);
    
    for (int i = 0; i < self.count; i++) {
        UIView * view = ((UIViewController *)self.BodyVCArr[i]).view;
        view.frame = CGRectMake(i * ViewWidth, 0, ViewWidth, viewHeight);
        [self.bodyScrollView addSubview:view];
    }
    
    
}

- (UIScrollView *)bodyScrollView{
    if (!_bodyScrollView) {
        _bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.headTitleHeight)];
        _bodyScrollView.backgroundColor = [UIColor grayColor];
        _bodyScrollView.bounces = NO;
        _bodyScrollView.delegate =self;
        _bodyScrollView.pagingEnabled = YES;
        _bodyScrollView.showsHorizontalScrollIndicator = NO;
        _bodyScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_bodyScrollView];
    }
    return _bodyScrollView;

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat ViewWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.currentIndex = scrollView.contentOffset.x / ViewWidth;

    CGFloat x = self.minheadTitleWidth * self.currentIndex;
    CGFloat space = (self.headScrollView.contentSize.width - ViewWidth) / (self.count - 1);
    UIButton * button = [self.headScrollView viewWithTag:1000 + self.currentIndex];
    self.headBt.selected = NO;
    self.headBt = button;
    self.headBt.selected = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.headLine.frame = CGRectMake(x, self.headTitleHeight - 4, self.minheadTitleWidth,4);
        [self.headScrollView setContentOffset:CGPointMake(space * self.currentIndex, 0)];
    }];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
