//
//  CarouselView.m
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "CarouselView.h"
#import "ZoomScrollView.h"

@interface CarouselView ()

<
UIScrollViewDelegate
>

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *currentImageArr;

@end

@implementation CarouselView

- (void)dealloc {
    [_imageURLArr release];
    [_currentImageArr release];
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentImageArr = [NSMutableArray array];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        [_scrollView release];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.f alpha:0.4f];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        [_pageControl release];
        
        
    }
    return self;
}

- (void)setImageURLArr:(NSArray *)imageURLArr {
 
    if (_imageURLArr != imageURLArr) {
        [_imageURLArr release];
        _imageURLArr = [imageURLArr retain];
        
        if (_currentImageArr.count > 0) {
            [_currentImageArr removeAllObjects];
            for (UIView *subView in _scrollView.subviews) {
                if ([subView isKindOfClass:[UIScrollView class]]) {
                    [subView removeFromSuperview];
                }
            }
        }
        [_currentImageArr addObject:[_imageURLArr lastObject]];
        [_currentImageArr addObjectsFromArray:_imageURLArr];
        [_currentImageArr addObject:[_imageURLArr firstObject]];
        
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _currentImageArr.count, self.bounds.size.height);
        
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageURLArr.count];
        CGPoint pageControlOrigin = {(self.bounds.size.width - pageControlSize.width) / 2, self.bounds.size.height - pageControlSize.height};
        CGRect pageControlFrame = {pageControlOrigin,pageControlSize};
        
        _pageControl.frame = pageControlFrame;
        _pageControl.numberOfPages = _imageURLArr.count;
        _pageControl.currentPage = 0;
        
        
        
        
        for (int i = 0; i< _currentImageArr.count; i++) {
            CGPoint zoomViewOrigin = {i * self.bounds.size.width, 0};
            CGSize zoomViewSize = {self.bounds.size.width, self.bounds.size.height};
            CGRect zoomViewFrame = {zoomViewOrigin, zoomViewSize};
            
            ZoomScrollView *zoomScrollView = [[ZoomScrollView alloc] initWithFrame:zoomViewFrame];
            zoomScrollView.imageURLString = _currentImageArr[i];
            zoomScrollView.tag = 1101 + i;
            zoomScrollView.delegate = self;
            [_scrollView addSubview:zoomScrollView];
            [zoomScrollView release];
            
            UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
            [zoomScrollView addGestureRecognizer:tapImage];
            [tapImage release];
            
            _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
            
            
            if (_timer) {
                [_timer invalidate];
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
            
        }
        
        
    }

    
}



- (void)timerAction:(NSTimer *)timer {
    NSInteger pageNumber = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    if (_imageURLArr.count == pageNumber) {
        pageNumber = 0;
        _scrollView.contentOffset = CGPointMake(pageNumber * _scrollView.bounds.size.width, 0);
    }
    [_scrollView setContentOffset:CGPointMake((pageNumber + 1) * _scrollView.bounds.size.width, 0) animated:YES];
    _pageControl.currentPage = pageNumber;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ([scrollView isEqual:_scrollView]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];
    }
}


- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [_scrollView setContentOffset:CGPointMake((pageControl.currentPage + 1) * self.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        NSInteger pageNum = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (0 == pageNum) {
            pageNum = _imageURLArr.count;
        } else if (_imageURLArr.count + 1 == pageNum) {
            pageNum = 1;
        }
        
        _pageControl.currentPage = pageNum - 1;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * pageNum, 0);
        
        
        
    }
    
}


- (void)tapImageAction:(UITapGestureRecognizer *)tapImage {
    [self.delegate getImageNum:tapImage.view.tag - 1101];
}



@end
