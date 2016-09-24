//
//  ZoomScrollView.m
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ZoomScrollView.h"
#import "UIImageView+XLWebCache.h"
#import "ScrollViewModel.h"

@interface ZoomScrollView ()

@property (nonatomic, retain) UIImageView *imageView;

@end

@implementation ZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageView];
        [_imageView release];
    }
    return self;
}

- (void)setImageURLString:(NSString *)imageURLString {
    if (_imageURLString != imageURLString) {
        [_imageURLString release];
        _imageURLString = [imageURLString retain];
        [_imageView xl_setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:nil];
    }
}


@end
