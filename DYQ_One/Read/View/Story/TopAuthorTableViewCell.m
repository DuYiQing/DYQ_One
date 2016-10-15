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
#import "SerialModel.h"
#import "BH_AVPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIButton+Block.h"

@interface TopAuthorTableViewCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) UILabel *playLabel;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, copy) NSString *audioString;
@property (nonatomic, retain) BH_AVPlayerView *playerView;

@end

@implementation TopAuthorTableViewCell
- (void)dealloc {
    [_playButton release];
    [_headImageView release];
    [_nameLabel release];
    [_dateLabel release];
    [_player release];
    [_playLabel release];
    [_audioString release];
    [_playerView release];
    
    [super dealloc];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    _isPlaying = NO;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.isPlaying = NO;
        
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImageView.backgroundColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
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
        
        [_playButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
            self.playerView = [BH_AVPlayerView sharePlayer];
        
            if (_audioString != nil) {
                _playerView.playerUrl = [NSURL URLWithString:_audioString];
                
                if (_isPlaying == NO) {
                    [_playButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
                    [_playerView play];
                    _isPlaying = YES;
                    
                } else {
                    [_playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
                    [_playerView pause];
                    _isPlaying = NO;
                }
            }
        }];
        
        
        self.playLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _playLabel.text = @"收听";
        _playLabel.textColor = [UIColor grayColor];
        _playLabel.font = kFONT_SIZE_12_BOLD;
        [self.contentView addSubview:_playLabel];
        [_playLabel release];
    }
    return self;
}

//- (void)createPlayer {
//    [_playButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
//    self.playerView = [BH_AVPlayerView sharePlayer];
//    if (_audioString != nil) {
//        NSURL *url = [NSURL URLWithString:_audioString];
//        _playerView.playerUrl = url;
//    }
//    [_playerView play];
//    _isPlaying = NO;
//}
//- (void)stopPlayingNovel {
//    [_playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
//    [_playerView pause];
//    _isPlaying = YES;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _headImageView.frame = CGRectMake(30, 30, 60, 60);
    _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2;
    _headImageView.clipsToBounds = YES;
    _nameLabel.frame = CGRectMake(100, 35, 200, 40);
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
        
        AuthorInfoModel *authorInfoModel = novelModel.author[0];
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:authorInfoModel.web_url] placeholderImage:[UIImage imageNamed:@"robot.png"]];
        _nameLabel.text = novelModel.hp_author;
        NSString *maketime = [novelModel.hp_makettime substringToIndex:11];
        _dateLabel.text = maketime;
        self.audioString = novelModel.audio;
    }
}

- (void)setSerialModel:(SerialModel *)serialModel {
    if (_serialModel != serialModel) {
        [_serialModel release];
        _serialModel = [serialModel retain];
        
        [_headImageView xl_setImageWithURL:[NSURL URLWithString:serialModel.author.web_url] placeholderImage:[UIImage imageNamed:@"robot.png"]];
        _nameLabel.text = serialModel.author.user_name;
        _dateLabel.text = serialModel.maketime;
        [_playButton removeFromSuperview];
        [_playLabel removeFromSuperview];
    }
}




@end
