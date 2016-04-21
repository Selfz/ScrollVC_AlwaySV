//
//  AlwayScrollerView.m
//  AlwayScrollingView
//
//  Created by lushouxiang on 15/12/24.
//  Copyright © 2015年 zxw. All rights reserved.
//

#import "AlwayScrollerView.h"



@interface AlwayScrollerView () <UIScrollViewDelegate>
{
    CGFloat SELF_WIDTH ;
    CGFloat SELF_HEIGHT ;
    CGFloat IMAGEVIEW_COUNT ;
    
    UIScrollView *_scrollView;
    
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    
    UIPageControl *_pageControl;
    UILabel *_label;
    NSMutableDictionary *_imageData;//图片数据
    
    NSTimer * timer;
    
    int _letfIndex;
    int _rightIndex;
    int _currentImageIndex;//当前图片索引
    int _imageCount;//图片总数
}


@property (nonatomic ,strong) UIScrollView * scrollView;
@property (nonatomic ,strong) UIPageControl * pageControl;
@property (nonatomic ,strong) NSArray * images;

@end

@implementation AlwayScrollerView



+ (instancetype)alwayScrollerViewWithImgNameArr:(NSArray *)imageArr frame:(CGRect)frame{
    AlwayScrollerView * sView = [[self alloc] initWithFrame:frame];
    
    NSMutableArray * arrImg = [NSMutableArray array];
    for (NSString * name in imageArr) {
        UIImage * image = [UIImage imageNamed:name];
        [arrImg addObject:image];
    }
    sView.images = arrImg;
    
    return sView;
}

+ (instancetype)alwayScrollerViewWithImageArr:(NSArray *)imageArr frame:(CGRect)frame{
    AlwayScrollerView * sView = [[self alloc] initWithFrame:frame];

    sView.images = imageArr;
    
    return sView;
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        SELF_WIDTH = frame.size.width;
        SELF_HEIGHT = frame.size.height;
    }
    return self;
}


- (void)setIsHidenPageController:(BOOL)isHidenPageController{
    if (isHidenPageController) {
        _isHidenPageController = isHidenPageController;
    } else {
        _isHidenPageController = isHidenPageController;
        [self addPageControlView:self.images];
    }
}



- (void)autoAnimetionTimeInterval:(NSTimeInterval)time{
    
    timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}



- (void)timerAction{
    
    [self.scrollView setContentOffset:CGPointMake(SELF_WIDTH * 2, 0) animated:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self didScrollLeft:NO];
    });
}




- (void)setImages:(NSArray *)images{
    if (_images != images) {
        _images = images;
        
        IMAGEVIEW_COUNT = 3;
        
        [self creatScrollerView:_images];
        
        [self addImageViews:_images];
    }
}




- (void)creatScrollerView:(NSArray *)images{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake(IMAGEVIEW_COUNT * SELF_WIDTH, SELF_HEIGHT);
    
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.scrollView setContentOffset:CGPointMake(SELF_WIDTH, 0) animated:NO];
    _currentImageIndex = 0;
    
    [self addSubview:self.scrollView];
}



- (void) addImageViews:(NSArray *)images{
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT)];
    _leftImageView.image = [images lastObject];
    [self.scrollView addSubview:_leftImageView];
    
    
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SELF_WIDTH, 0, SELF_WIDTH, SELF_HEIGHT)];
    _centerImageView.image = [images firstObject];
    _centerImageView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_centerImageView];
    
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SELF_WIDTH * 2, 0, SELF_WIDTH, SELF_HEIGHT)];
    _rightImageView.image = images[1];
    [self.scrollView addSubview:_rightImageView];
}


- (void)addPageControlView:(NSArray *)images{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SELF_HEIGHT - 30, SELF_WIDTH, 30)];
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = _currentImageIndex;
    self.pageControl.userInteractionEnabled = NO;
    
    [self addSubview:self.pageControl];
}





- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:MAXFLOAT]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}





- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == SELF_WIDTH) return;
 
    BOOL isLeft = scrollView.contentOffset.x < SELF_WIDTH ? YES : NO;
    
    [self didScrollLeft:isLeft];
    
 
}



- (void)didScrollLeft:(BOOL)isLeft{

    _currentImageIndex = isLeft ? _currentImageIndex - 1: _currentImageIndex + 1;
    _currentImageIndex = _currentImageIndex < 0 ?(int)self.images.count -1:_currentImageIndex;
    _currentImageIndex = _currentImageIndex > (int)self.images.count -1 ?0:_currentImageIndex;
    

    _letfIndex = (_currentImageIndex - 1) < 0? (int)self.images.count -1: _currentImageIndex - 1;
    _rightIndex = _currentImageIndex + 1 > (int)self.images.count -1 ?0:_currentImageIndex + 1;
    
    
    _leftImageView.image = self.images[_letfIndex];
    _centerImageView.image = self.images[_currentImageIndex];
    _rightImageView.image = self.images[_rightIndex];
    
    
    self.pageControl.currentPage = _currentImageIndex;
    [self.scrollView setContentOffset:CGPointMake(SELF_WIDTH, 0) animated:NO];

}



@end
