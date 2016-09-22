//
//  LikeView.m
//  DYQ_One
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LikeView.h"
#import "RootModel.h"

@interface LikeView ()

@property (nonatomic, retain) UIImageView *heartImageView;


@end

@implementation LikeView

- (void)dealloc {
    [_heartImageView release];
    [_numLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.heartImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _heartImageView.image = [UIImage imageNamed:@"Unknown-11.png"];
        [self addSubview:_heartImageView];
        [_heartImageView release];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = [UIColor lightGrayColor];
        _numLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_numLabel];
        [_numLabel release];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _heartImageView.frame = CGRectMake(0, 0, 20, 20);
    
    _numLabel.frame = CGRectMake(_heartImageView.bounds.size.width + 10, 0, 50, 20);
}

- (void)setRootModel:(RootModel *)rootModel {
    if (_rootModel != rootModel) {
        [_rootModel release];
        _rootModel = [rootModel retain];
        _numLabel.text = [NSString stringWithFormat:@"%@", rootModel.praisenum];
    }
}


@end
