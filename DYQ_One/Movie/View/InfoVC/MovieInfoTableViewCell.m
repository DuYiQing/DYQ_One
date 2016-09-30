//
//  MovieInfoTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieInfoTableViewCell.h"
#import "MovieInfoModel.h"
#import "MovieStoryModel.h"
#import "UIImageView+XLWebCache.h"

@interface MovieInfoTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIImageView *likeImageView;
@property (nonatomic, retain) UILabel *numLabel;

@end

@implementation MovieInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView release];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _authorLabel.backgroundColor = [UIColor yellowColor];
        _authorLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        _authorLabel.font = kFONT_SIZE_12_BOLD;
        [self.contentView addSubview:_authorLabel];
        [_authorLabel release];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _dateLabel.backgroundColor = [UIColor greenColor];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = kFONT_SIZE_12_BOLD;
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        self.likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [UIImage imageNamed:@"Unknown-11.png"];
        [self.contentView addSubview:_likeImageView];
        [_likeImageView release];
        
        self.numLabel = [[UILabel alloc] init];
//        _numLabel.text = @"1111";
        [self.contentView addSubview:_numLabel];
        [_numLabel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(20, 20, 40, 40);
    _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2;
    _headImageView.clipsToBounds = YES;
    _authorLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.bounds.size.width + 5, _headImageView.frame.origin.y + 5, SCREEN_WIDTH / 2, 25);
    [_authorLabel sizeToFit];
    _dateLabel.frame = CGRectMake(_authorLabel.frame.origin.x, _authorLabel.frame.origin.y + _authorLabel.bounds.size.height + 5, SCREEN_WIDTH / 2, 25);
    [_dateLabel sizeToFit];
    _likeImageView.frame = CGRectMake(320, self.contentView.bounds.size.height / 2 - 12, 20, 20);
    _numLabel.frame = CGRectMake(_likeImageView.frame.origin.x + _likeImageView.bounds.size.width + 5, _likeImageView.frame.origin.y, 50, 24);
    
    
}

- (void)setMovieStoryArr:(NSArray *)movieStoryArr {
    if (_movieStoryArr != movieStoryArr) {
        [_movieStoryArr release];
        _movieStoryArr = [movieStoryArr retain];
        
        MovieStoryModel *movieStoryModel = _movieStoryArr[0];
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:movieStoryModel.user.web_url] placeholderImage:nil];
        _authorLabel.text = movieStoryModel.user.user_name;
        _dateLabel.text = movieStoryModel.input_date;
        _numLabel.text = [NSString stringWithFormat:@"%@", movieStoryModel.praisenum];
    }
}

- (void)setMovieInfoModel:(MovieInfoModel *)movieInfoModel {
    if (_movieInfoModel != movieInfoModel) {
        [_movieInfoModel release];
        _movieInfoModel = [movieInfoModel retain];
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
