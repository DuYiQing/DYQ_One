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

@interface BottonAuthorTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) UILabel *weiboLabel;

@end

@implementation BottonAuthorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.backgroundColor = [UIColor blueColor];
        _nameLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.backgroundColor = [UIColor grayColor];
        _descLabel.textColor = [UIColor lightGrayColor];
        _descLabel.font = kFONT_SIZE_13;
        [self.contentView addSubview:_descLabel];
        [_descLabel release];

        
        self.weiboLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _weiboLabel.backgroundColor = [UIColor cyanColor];
        _weiboLabel.textColor = [UIColor lightGrayColor];
        _weiboLabel.font = kFONT_SIZE_13;
        [self.contentView addSubview:_weiboLabel];
        [_weiboLabel release];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(30, 30, 60, 60);
    _nameLabel.frame = CGRectMake(100, 30, 200, 40);
    [_nameLabel sizeToFit];
    _descLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height + 10, 200, 40);
    [_descLabel sizeToFit];
    _weiboLabel.frame = CGRectMake(100, 90, 250, 40);
//    [_weiboLabel sizeToFit];
}

- (void)setNovelModel:(NovelModel *)novelModel {
    if (_novelModel != novelModel) {
        [_novelModel release];
        _novelModel = [novelModel retain];
        
//        AuthorInfoModel *authorInfoModel = novelModel.author[0];
//        [_headImageView xl_setImageWithURL:[NSURL URLWithString:authorInfoModel.web_url] placeholderImage:[UIImage imageNamed:@"Unknown-1.png"]];
        _nameLabel.text = novelModel.hp_author;
        _descLabel.text = novelModel.auth_it;
//        _weiboLabel.text = authorInfoModel.wb_name;
    }
}




@end
