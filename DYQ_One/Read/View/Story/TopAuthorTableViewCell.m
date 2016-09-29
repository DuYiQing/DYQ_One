//
//  TopAuthorTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TopAuthorTableViewCell.h"
#import "AuthorInfoModel.h"
#import "NovelModel.h"
#import "UIImageView+XLWebCache.h"

@interface TopAuthorTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) UILabel *playLabel;

@end


@implementation TopAuthorTableViewCell
- (void)dealloc {
    [_playButton release];
    [_playLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _nameLabel.backgroundColor = [UIColor blueColor];
        _nameLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        _nameLabel.font = kFONT_SIZE_15_BOLD;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _dateLabel.backgroundColor = [UIColor grayColor];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = kFONT_SIZE_13;
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];

        
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_playButton];
        
        self.playLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _playLabel.text = @"收听";
        _playLabel.textColor = [UIColor grayColor];
        _playLabel.font = kFONT_SIZE_12_BOLD;
        [self.contentView addSubview:_playLabel];
        [_playLabel release];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _headImageView.frame = CGRectMake(30, 30, 60, 60);
    _nameLabel.frame = CGRectMake(100, 30, 200, 40);
    [_nameLabel sizeToFit];
    _dateLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height + 10, 200, 40);
    [_dateLabel sizeToFit];
    _playButton.frame = CGRectMake(350, 50, 20, 20);
    _playLabel.frame = CGRectMake(_playButton.frame.origin.x + _playButton.bounds.size.width + 5, _playButton.frame.origin.y - 5, 40, 30);
}

- (void)setNovelModel:(NovelModel *)novelModel {
    if (_novelModel != novelModel) {
        [_novelModel release];
        _novelModel = [novelModel retain];
        
//        AuthorInfoModel *authorInfoModel = novelModel.author[0];
//        [_headImageView xl_setImageWithURL:[NSURL URLWithString:authorInfoModel.web_url] placeholderImage:nil];
        _nameLabel.text = novelModel.hp_author;
        _dateLabel.text = novelModel.hp_makettime;
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
