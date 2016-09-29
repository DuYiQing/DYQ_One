//
//  ReadTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReadTableViewCell.h"
#import "EssayModel.h"
#import "SerialModel.h"
#import "QuestionModel.h"
#import "AuthorInfoModel.h"

@interface ReadTableViewCell ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *typeLabel;

@end

@implementation ReadTableViewCell

- (void)dealloc {
    [_titleLabel release];
    [_authorLabel release];
    [_contentLabel release];
    [_typeLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _authorLabel.backgroundColor = [UIColor orangeColor];
        _authorLabel.numberOfLines = 0;
        _authorLabel.textColor = [UIColor grayColor];
        _authorLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_authorLabel];
        [_authorLabel release];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _contentLabel.backgroundColor = [UIColor yellowColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel release];
        
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeLabel.layer.borderColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0].CGColor;
        _typeLabel.layer.borderWidth = 1.f;
        _typeLabel.layer.cornerRadius = 5.f;
        _typeLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_typeLabel];
        [_typeLabel release];
        
    }
    return self;
}

- (void)setEssayModel:(EssayModel *)essayModel {
    if (_essayModel != essayModel) {
        [_essayModel release];
        _essayModel = [essayModel retain];
        
        _titleLabel.text = essayModel.hp_title;
        AuthorInfoModel *authorModel = essayModel.author[0];
        _authorLabel.text = authorModel.user_name;
        _contentLabel.text = essayModel.guide_word;
        _typeLabel.text = @"短 篇";
    }
}

- (void)setSerialModel:(SerialModel *)serialModel {
    if (_serialModel != serialModel) {
        [_serialModel release];
        _serialModel = [serialModel retain];
        
        _titleLabel.text = serialModel.title;
        _authorLabel.text = serialModel.author.user_name;
        _contentLabel.text = serialModel.excerpt;
        _typeLabel.text = @"连 载";
    }
}

- (void)setQuestionModel:(QuestionModel *)questionModel {
    if (_questionModel != questionModel) {
        [_questionModel release];
        _questionModel = [questionModel retain];
        
        _titleLabel.text = questionModel.question_title;
        _authorLabel.text = questionModel.answer_title;
        _contentLabel.text = questionModel.answer_content;
        _typeLabel.text = @"问 答";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20, 25, SCREEN_WIDTH - 95, 40);
    [_titleLabel sizeToFit];

    
    _authorLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 10, SCREEN_WIDTH - 95, 40);
    [_authorLabel sizeToFit];

    
    _contentLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _authorLabel.frame.origin.y + _authorLabel.bounds.size.height + 10, self.contentView.bounds.size.width - 40, 80);
    [_contentLabel sizeToFit];
    
    _typeLabel.frame = CGRectMake(self.contentView.bounds.size.width - 10 - 55, _titleLabel.frame.origin.y, 45, 20);
    
    _rowHeight = _contentLabel.frame.origin.y + _contentLabel.bounds.size.height + 15;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
