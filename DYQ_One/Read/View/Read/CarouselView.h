//
//  CarouselView.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselViewDelegate <NSObject>

- (void)getImageNum:(NSInteger)imageNum;

@end

@interface CarouselView : UIView

@property (nonatomic, retain) NSArray *imageURLArr;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) id<CarouselViewDelegate>delegate;


@end
