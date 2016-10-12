//
//  MusicCollectionViewCell.m
//  DYQ_One
//
//  Created by DYQ on 16/9/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MusicCollectionViewCell.h"
#import "MusicModel.h"
#import "UIImageView+XLWebCache.h"
#import "BottonAuthorTableViewCell.h"
#import "CommentModel.h"
#import <AVFoundation/AVFoundation.h>
#import "BH_AVPlayerView.h"
#import "MJRefresh.h"
#import "HttpClient.h"

@interface MusicCollectionViewCell ()

<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *musicTableView;
@property (nonatomic, retain) UIImageView *topImageView;
@property (nonatomic, retain) UIView *songView;
@property (nonatomic, retain) UIImageView *songImageView;
@property (nonatomic, retain) UILabel *songAuthorLabel;
@property (nonatomic, retain) UILabel *typeLabel;
@property (nonatomic, retain) UILabel *songNameLabel;
@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, copy) NSString *commentNumber;


@end

@implementation MusicCollectionViewCell

- (void)dealloc {
    [_musicTableView release];
    [_topImageView release];
    [_songView release];
    [_typeLabel release];
    [_songNameLabel release];
    [_dateLabel release];
    [_commentNumber release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.musicTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _musicTableView.dataSource = self;
        _musicTableView.delegate = self;
        // 设置tableView的cell分割线样式为无
        _musicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_musicTableView];
        [_musicTableView release];
        
        _musicTableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT / 4 * 3, 0, 0, 0);
        _musicTableView.contentOffset = CGPointMake(0, -SCREEN_HEIGHT / 4);
        self.topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_musicTableView addSubview:_topImageView];
        [_topImageView release];
        
        // songView显示歌手歌曲信息
        self.songView = [[UIView alloc] init];
        _songView.backgroundColor = [UIColor whiteColor];
        _songView.layer.cornerRadius = 3.f;
        // 设置View的边框
        _songView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _songView.layer.borderWidth = 2.f;
        [_musicTableView addSubview:_songView];
        [_songView release];
        
        
        // 头像
        self.songImageView = [[UIImageView alloc] init];
//        _songImageView.backgroundColor = [UIColor blackColor];
        [_songView addSubview:_songImageView];
        [_songImageView release];
        
        // 歌手
        self.songAuthorLabel  = [[UILabel alloc] init];
        _songAuthorLabel.backgroundColor = [UIColor whiteColor];
        _songAuthorLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
        _songAuthorLabel.font = kFONT_SIZE_12_BOLD;
        [_songView addSubview:_songAuthorLabel];
        [_songAuthorLabel release];
        
        // 歌手标签
        self.typeLabel = [[UILabel alloc] init];
//        _typeLabel.backgroundColor = [UIColor purpleColor];
        _typeLabel.textColor = [UIColor lightGrayColor];
        _typeLabel.font = kFONT_SIZE_12_BOLD;
        [_songView addSubview:_typeLabel];
        [_typeLabel release];
        
        // 歌名
        self.songNameLabel = [[UILabel alloc] init];
        _songNameLabel.backgroundColor = [UIColor whiteColor];
        _songAuthorLabel.font = kFONT_SIZE_18_BOLD;
        [_songView addSubview:_songNameLabel];
        [_songNameLabel release];
        
        // 播放歌曲按钮
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _playButton.backgroundColor = [UIColor whiteColor];
        [_playButton setImage:[UIImage imageNamed:@"musicPlay.png"] forState:UIControlStateNormal];
        [_songView addSubview:_playButton];
        
        self.dateLabel = [[UILabel alloc] init];
//        _dateLabel.backgroundColor = [UIColor lightGrayColor];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = kFONT_SIZE_12_BOLD;
        [_songView addSubview:_dateLabel];
        [_dateLabel release];
        
        _musicTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
        
    }
    return self;
}
- (void)Loading {
    [self commentData];
    [_musicTableView reloadData];
    [_musicTableView.mj_footer endRefreshing];
    
}

// 加载评论内容
- (void)commentData {
    CommentModel *commentModel = [_commentArr lastObject];
    self.commentNumber = commentModel.ID;
    
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/music/%@/%@", _musicModel.ID, _commentNumber] success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSArray *dataArr = [dataDic objectForKey:@"data"];
        for (NSDictionary *commentDic in dataArr) {
            CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
            [_commentArr addObject:commentModel];
        }
        [_musicTableView reloadData];
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _musicTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _topImageView.frame = CGRectMake(0, -SCREEN_HEIGHT / 4 * 3, SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2);
    _songView.frame = CGRectMake(15, -100, SCREEN_WIDTH - 30, 110);
    
    _songImageView.frame = CGRectMake(15, 15, 50, 50);
    _songImageView.layer.cornerRadius = _songImageView.bounds.size.width / 2;
    _songImageView.clipsToBounds = YES;
    
    _songAuthorLabel.frame = CGRectMake(_songImageView.frame.origin.x + _songImageView.bounds.size.width + 10, _songImageView.frame.origin.y + 5, 200, 20);
    
    _typeLabel.frame = CGRectMake(_songAuthorLabel.frame.origin.x, _songAuthorLabel.frame.origin.y + _songAuthorLabel.bounds.size.height + 3, 100, 20);
    
    _songNameLabel.frame = CGRectMake(_songImageView.frame.origin.x, _songImageView.frame.origin.y + _songImageView.bounds.size.height + 10, 200, 30);
    
    _playButton.frame = CGRectMake(_songView.bounds.size.width / 7 * 6, _songView.bounds.size.height / 3, _songView.bounds.size.height / 3, _songView.bounds.size.height / 3);
    _dateLabel.frame = CGRectMake(_songView.bounds.size.width / 4 * 3 + 10, _playButton.frame.origin.y + _playButton.bounds.size.height + 8, 83, 20);
    _dateLabel.textAlignment = NSTextAlignmentRight;
    [_dateLabel sizeToFit];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            return 40;
        }
        if (1 == indexPath.row) {
            return 40;
        }
        NSString *info = _storyArr[indexPath.row - 2];
        CGSize infoSize = CGSizeMake(SCREEN_WIDTH, 1000);
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
        CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        return ceil(infoRect.size.height);
    }
    return 130;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return @"音乐故事";
    }
    if (1 == section) {
        return @"评论列表";
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (1 == section) {
        return @"                                       以上是热门评论";
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return _storyArr.count + 2;
    }
    if (1 == section) {
        if (_commentArr.count < 8) {
            return _commentArr.count;
        }
        return 8;
    }
    if (2 == section) {
        return _commentArr.count - 8;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            if (nil == cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"] autorelease];
            }
            cell.textLabel.text = _musicModel.story_title;
            cell.textLabel.font = kFONT_SIZE_18_BOLD;
            [cell.textLabel sizeToFit];
            return  cell;

        }
        if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"author"];
            if (nil == cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"author"] autorelease];
            }
            cell.textLabel.text = _musicModel.story_author.user_name;
            cell.textLabel.textColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
            cell.textLabel.font = kFONT_SIZE_12_BOLD;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.textLabel sizeToFit];
            return  cell;

        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"story"];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"story"] autorelease];
        }
        cell.textLabel.text = _storyArr[indexPath.row - 2];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel sizeToFit];
        return  cell;
    }
    if (1 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"hotCell%ld", indexPath.row]];
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"hotCell%ld", indexPath.row]] autorelease];
        }
        CommentModel *commentModel = _commentArr[indexPath.row];
        cell.commentModel = commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (nil == cell) {
        cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]] autorelease];
    }
    CommentModel *commentModel = _commentArr[indexPath.row + 8];
    cell.commentModel = commentModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)setMusicModel:(MusicModel *)musicModel {
    if (_musicModel != musicModel) {
        [_musicModel release];
        _musicModel = [musicModel retain];
        
        [_topImageView xl_setImageWithURL:[NSURL URLWithString:musicModel.cover] placeholderImage:[UIImage imageNamed:@"28B58PICxtD_1024.png"]];
        [_songImageView xl_setImageWithURL:[NSURL URLWithString:musicModel.author.web_url] placeholderImage:nil];
        _songAuthorLabel.text = musicModel.author.user_name;
        _typeLabel.text = musicModel.author.desc;
        _songNameLabel.text = musicModel.title;
        NSString *maketime = [musicModel.maketime substringToIndex:11];
        _dateLabel.text = maketime;
        [_musicTableView reloadData];
    }
}


@end
