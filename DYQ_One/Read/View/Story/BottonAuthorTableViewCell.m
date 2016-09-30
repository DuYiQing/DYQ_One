//
//  BottonAuthorTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BottonAuthorTableViewCell.h"
#import "InfoBaseTableViewCell.h"
#import "NovelModel.h"
#import "AuthorInfoModel.h"
#import "UIImageView+XLWebCache.h"
#import "SerialModel.h"
#import "CommentModel.h"

@interface BottonAuthorTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) UILabel *weiboLabel;

@end

@implementation BottonAuthorTableViewCell

- (void)dealloc {
    [_headImageView release];
    [_nameLabel release];
    [_descLabel release];
    [_weiboLabel release];
    [_commentArr release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.backgroundColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        [self.contentView addSubview:_headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _nameLabel.backgroundColor = [UIColor blueColor];
        _nameLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _descLabel.backgroundColor = [UIColor grayColor];
        _descLabel.textColor = [UIColor lightGrayColor];
        _descLabel.numberOfLines = 0;
        _descLabel.font = kFONT_SIZE_13;
        [self.contentView addSubview:_descLabel];
        [_descLabel release];

        
        self.weiboLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _weiboLabel.backgroundColor = [UIColor cyanColor];
        _weiboLabel.textColor = [UIColor lightGrayColor];
        _weiboLabel.font = kFONT_SIZE_13;
        [self.contentView addSubview:_weiboLabel];
        [_weiboLabel release];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(25, 30, 60, 60);
    _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2;
    _headImageView .clipsToBounds = YES;
    _nameLabel.frame = CGRectMake(100, 35, 200, 40);
    [_nameLabel sizeToFit];
    _descLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height + 5, SCREEN_WIDTH - 120, 40);
    [_descLabel sizeToFit];
    _weiboLabel.frame = CGRectMake(100, _descLabel.frame.origin.y + _descLabel.bounds.size.height + 5, 250, 40);
    [_weiboLabel sizeToFit];
}

- (void)setNovelModel:(NovelModel *)novelModel {
    if (_novelModel != novelModel) {
        [_novelModel release];
        _novelModel = [novelModel retain];
        
        AuthorInfoModel *authorInfoModel = novelModel.author[0];
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:authorInfoModel.web_url] placeholderImage:[UIImage imageNamed:@"Unknown-1.png"]];
        _nameLabel.text = novelModel.hp_author;
        _descLabel.text = novelModel.auth_it;
        _weiboLabel.text = [NSString stringWithFormat:@"weibo:%@", authorInfoModel.wb_name];
    }
}
- (void)setSerialModel:(SerialModel *)serialModel {
    if (_serialModel != serialModel) {
        [_serialModel release];
        _serialModel = [serialModel retain];
        
        _nameLabel.text = serialModel.author.user_name;
        _descLabel.text = serialModel.author.desc;
    }
}
- (void)setCommentModel:(CommentModel *)commentModel {
    if (_commentModel != commentModel) {
        [_commentModel release];
        _commentModel = [commentModel retain];
        
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:commentModel.user.web_url] placeholderImage:nil];
        _nameLabel.text = commentModel.user.user_name;
        _descLabel.text = commentModel.input_date;
        _weiboLabel.text = commentModel.content;
    }
}

@end
