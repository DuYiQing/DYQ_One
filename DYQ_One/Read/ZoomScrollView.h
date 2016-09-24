//
//  ZoomScrollView.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollViewModel;

@interface ZoomScrollView : UIScrollView

@property (nonatomic, copy) NSString *imageURLString;
@property (nonatomic, retain) ScrollViewModel *scrollViewModel;

@end
