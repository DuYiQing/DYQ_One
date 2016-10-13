//
//  InfoBaseTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "InfoBaseTableViewCell.h"
#import "UIImageView+XLWebCache.h"
#import "AuthorInfoModel.h"
#import "SerialModel.h"
#import "CommentModel.h"


@interface InfoBaseTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descLabel;

@end

@implementation InfoBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _nameLabel.backgroundColor = [UIColor blueColor];
        _nameLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _descLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_descLabel];
        [_descLabel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(30, 30, 60, 60);
    _nameLabel.frame = CGRectMake(100, 30, 200, 40);
//    [_nameLabel sizeToFit];
    _descLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height + 10, 200, 40);
    
}

- (void)setSerialModel:(SerialModel *)serialModel {
    if (_serialModel != serialModel) {
        [_serialModel release];
        _serialModel = [serialModel retain];
        
        _nameLabel.text = serialModel.author.user_name;
        _descLabel.text = serialModel.author.desc;
    }
}

- (void)setCommentArr:(NSArray *)commentArr {
    if (_commentArr != commentArr) {
        [_commentArr release];
        _commentArr = [commentArr retain];
        
        CommentModel *commentModel = commentArr[_currentRow];
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:commentModel.user.web_url] placeholderImage:nil];
        _nameLabel.text = commentModel.user.user_name;
        _descLabel.text = commentModel.content;
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
