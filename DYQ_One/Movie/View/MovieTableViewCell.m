//
//  MovieTableViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "MovieModel.h"
#import "UIImageView+XLWebCache.h"

@interface MovieTableViewCell ()

@property (nonatomic, retain) UIImageView *movieImageVIew;
@property (nonatomic, retain) UILabel *scoreLabel;

@end

@implementation MovieTableViewCell
- (void)dealloc {
    [_movieImageVIew release];
    [_scoreLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //电影封面照
        self.movieImageVIew = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_movieImageVIew];
        [_movieImageVIew release];
        
        // 封面照上添加电影的评分
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        // 设置评分字体
        _scoreLabel.font = [UIFont fontWithName:@"Zapfino" size:24];
        _scoreLabel.textColor = [UIColor redColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [_movieImageVIew addSubview:_scoreLabel];
        [_scoreLabel release];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _movieImageVIew.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.bounds.size.height - 5);
    _scoreLabel.frame = CGRectMake(SCREEN_WIDTH / 3 * 2 + 30, _movieImageVIew.bounds.size.height / 3 * 2, SCREEN_WIDTH / 3 - 30, _movieImageVIew.bounds.size.height / 3);
}

- (void)setMovieModel:(MovieModel *)movieModel {
    if (_movieModel != movieModel) {
        [_movieModel release];
        _movieModel = [movieModel retain];

        [_movieImageVIew xl_setImageWithURL:[NSURL URLWithString:movieModel.cover] placeholderImage:nil];
        _scoreLabel.text = movieModel.score;

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
