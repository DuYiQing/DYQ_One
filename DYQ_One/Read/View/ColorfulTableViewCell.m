//
//  ColorfulTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ColorfulTableViewCell.h"
#import "ThreeLabelView.h"
#import "ColorfulViewModel.h"

@interface ColorfulTableViewCell ()

@property (nonatomic, retain) ThreeLabelView *threeLabelView;

@end

@implementation ColorfulTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.threeLabelView = [[ThreeLabelView alloc] initWithFrame:CGRectZero];
//        _threeLabelView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_threeLabelView];
        [_threeLabelView release];
    }
    return self;
}

- (void)setThreeLabelView:(ThreeLabelView *)threeLabelView {
    if (_threeLabelView != threeLabelView) {
        [_threeLabelView release];
        _threeLabelView = [threeLabelView retain];
        
    }
}

- (void)setColorfulModel:(ColorfulViewModel *)colorfulModel {
    if (_colorfulModel != colorfulModel) {
        [_colorfulModel release];
        _colorfulModel = [colorfulModel retain];
        
        _threeLabelView.titleLabel.text = _colorfulModel.title;
        _threeLabelView.authorLabel.text = _colorfulModel.author;
        _threeLabelView.contentLabel.text = _colorfulModel.introduction;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _threeLabelView.frame = CGRectMake(50, 10, self.contentView.bounds.size.width - 80, 120);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
