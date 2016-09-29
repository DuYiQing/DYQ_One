//
//  ContentTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "NovelModel.h"

@interface ContentTableViewCell ()

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, retain) UILabel *contentLabel;


@end

@implementation ContentTableViewCell

- (void)dealloc {
    [_contentLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel release];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentLabel.frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 20);
    [_contentLabel sizeToFit];

}

- (void)setContentArr:(NSArray *)contentArr {
    if (_contentArr != contentArr) {
        [_contentArr release];
        _contentArr = [contentArr retain];

        _contentLabel.text = _contentArr[_row];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
