//
//  ImageLabelView.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ImageLabelView.h"
#import "UIView+Frame.h"
#import "UIImage+Categories.h"
#import "UIImageView+XLWebCache.h"
#import "RootModel.h"
#import "DYQMacro.h"

@interface ImageLabelView ()

@property (nonatomic, retain) UIView *emptyView;


@end

@implementation ImageLabelView

- (void)dealloc {
    [_topImageView release];
    [_emptyView release];
    [_volLabel release];
    [_authorLabel release];
    [_contentLabel release];
    [_dateLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.emptyView = [[UIView alloc] initWithFrame:CGRectZero];
        _emptyView.layer.cornerRadius = 5.0f;
        _emptyView.layer.borderWidth = 2.0f;
        _emptyView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:_emptyView];
        [_emptyView release];
        
        self.topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _topImageView.backgroundColor = [UIColor orangeColor];
        [_emptyView addSubview:_topImageView];
        [_topImageView release];
        
        self.volLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _volLabel.backgroundColor = [UIColor redColor];
        _volLabel.textColor = [UIColor lightGrayColor];
        _volLabel.font = [UIFont systemFontOfSize:12];
        [_emptyView addSubview:_volLabel];
        [_volLabel release];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _authorLabel.backgroundColor = [UIColor redColor];
        _authorLabel.textColor = [UIColor lightGrayColor];
        _authorLabel.font = [UIFont systemFontOfSize:12];
        _authorLabel.textAlignment = NSTextAlignmentRight;
        [_emptyView addSubview:_authorLabel];
        [_authorLabel release];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _contentLabel.backgroundColor = [UIColor yellowColor];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
        [_emptyView addSubview:_contentLabel];
        [_contentLabel release];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _dateLabel.backgroundColor = [UIColor greenColor];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        [_emptyView addSubview:_dateLabel];
        [_dateLabel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_topImageView.image imageByScalingProportionallyToSize:_topImageView.image.size];
    _topImageView.frame = CGRectMake(5, 5, SCREEN_WIDTH - 30, 300);
    
    
    
//    _topImageView.frame = CGRectMake(5, 5, _emptyView.bounds.size.width - 10, 100);
    
    _volLabel.frame = CGRectMake(_topImageView.frame.origin.x, _topImageView.frame.origin.y + _topImageView.bounds.size.height + 5, 80, 20);
    
    _authorLabel.frame = CGRectMake(_volLabel.frame.origin.x + _volLabel.bounds.size.width + 15, _volLabel.frame.origin.y, _topImageView.bounds.size.width - _volLabel.bounds.size.width - 15 , _volLabel.bounds.size.height);
    
    _contentLabel.frame = CGRectMake(_topImageView.frame.origin.x, _authorLabel.frame.origin.y + _authorLabel.bounds.size.height + 10, _topImageView.bounds.size.width, 100);
    
    _dateLabel.frame = CGRectMake(SCREEN_WIDTH / 2, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 30, _topImageView.bounds.size.width / 2 - 10, _volLabel.bounds.size.height);
    
    
    _emptyView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, _topImageView.bounds.size.height + _authorLabel.bounds.size.height + _contentLabel.bounds.size.height + _dateLabel.bounds.size.height + 55);
    
    
    
}

- (void)setRootModel:(RootModel *)rootModel {
    if (_rootModel != rootModel) {
        [_rootModel release];
        _rootModel = [rootModel retain];
        
        [_topImageView xl_setImageWithURL:[NSURL URLWithString:_rootModel.hp_img_url] placeholderImage:nil];
        _volLabel.text = rootModel.hp_title;
        _authorLabel.text = rootModel.hp_author;
        _contentLabel.text = rootModel.hp_content;
        _dateLabel.text = rootModel.hp_makettime;
    }
}



@end
