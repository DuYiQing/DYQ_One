//
//  ThreeLabelView.m
//  DYQ_One
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ThreeLabelView.h"
#import "ColorfulViewModel.h"

#import "SystemUnit.h"


@implementation ThreeLabelView

- (void)dealloc {
    [_titleLabel release];
    [_authorLabel release];
    [_contentLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        [_titleLabel release];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _authorLabel.backgroundColor = [UIColor orangeColor];
        _authorLabel.textColor = [UIColor whiteColor];
        _authorLabel.font = kFONT_SIZE_12_BOLD;
        _authorLabel.numberOfLines = 2;
        [self addSubview:_authorLabel];
        [_authorLabel release];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _contentLabel.backgroundColor = [UIColor yellowColor];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
        [_contentLabel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
//    [_titleLabel sizeToFit];
    
    _authorLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 5, self.bounds.size.width, 18);
//    [_authorLabel sizeToFit];
    
    _contentLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _authorLabel.frame.origin.y + _authorLabel.bounds.size.height + 5, self.bounds.size.width, 40);
//    [_contentLabel sizeToFit];
}

- (void)setColorfulModel:(ColorfulViewModel *)colorfulModel {
    if (_colorfulModel != colorfulModel) {
        [_colorfulModel release];
        _colorfulModel = [colorfulModel retain];
    }
}

@end
