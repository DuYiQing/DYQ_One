//
//  SearchTableViewCell.m
//  DYQ_One
//
//  Created by DYQ on 16/10/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "HPModel.h"
#import "UIImageView+XLWebCache.h"

@interface SearchTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *guideLabel;

@end

@implementation SearchTableViewCell
- (void)dealloc {
    [_headImageView release];
    [_dateLabel release];
    [_guideLabel release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
        [self.contentView addSubview:_headImageView];
        [_headImageView release];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.frame.origin.x + _headImageView.bounds.size.width + 5, _headImageView.frame.origin.y, 200, 30)];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        self.guideLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dateLabel.frame.origin.x, _dateLabel.frame.origin.y + _dateLabel.bounds.size.height + 5, 300, 30)];
        _guideLabel.textColor = [UIColor grayColor];
        _guideLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_guideLabel];
        [_guideLabel release];
    }
    return self;
}

- (void)setHpModel:(HPModel *)hpModel {
    if (_hpModel != hpModel) {
        [_hpModel release];
        _hpModel = [hpModel retain];
        
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:hpModel.hp_img_url] placeholderImage:[UIImage imageNamed:@"robot.png"]];
        _dateLabel.text = hpModel.hp_title;
        _guideLabel.text = hpModel.hp_content;
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
