//
//  MovieInfoViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieInfoViewController.h"
#import "HttpClient.h"
#import "MovieModel.h"
#import "MovieInfoTableViewCell.h"
#import "MJExtension.h"
#import "MovieInfoModel.h"
#import "MovieStoryModel.h"
#import "CarouselView.h"
#import "ScrollViewModel.h"
#import "UIImageView+XLWebCache.h"
#import "BottonAuthorTableViewCell.h"
#import "CommentModel.h"
#import "MJRefresh.h"
#import <AVFoundation/AVFoundation.h>
#import "BH_AVPlayerView.h"
#import "TargetTableViewCell.h"
#import "MovieTargetSectionHeaderView.h"


static NSString *const movieCell = @"movieCell";

@interface MovieInfoViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
MovieTargetSectionHeaderViewDelegate
>

@property (nonatomic, retain) UITableView *movieTableView;
@property (nonatomic, retain) MovieInfoModel *movieInfoModel;
@property (nonatomic, retain) NSMutableArray *movieStoryArr;
@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, retain) NSMutableArray *commentArr;
@property (nonatomic, copy) NSString *commentNumber;
@property (nonatomic, retain) BH_AVPlayerView *playerView;
@property (nonatomic, retain) NSArray *targetArr;
@property (nonatomic, assign) NSInteger buttonTag;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) TargetTableViewCell *targetCell;
@property (nonatomic, retain) UITableViewCell *actorsCell;


@end

@implementation MovieInfoViewController

- (void)dealloc {
    [_movieTableView release];
    [_contentArr release];
    [_movieStoryArr release];
    [_commentArr release];
    [_commentNumber release];
    [_playerView release];
    [_targetArr release];
    [_targetCell release];
    [_actorsCell release];
    [_backButton release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
    self.movieStoryArr = [NSMutableArray array];
    self.contentArr = [NSArray array];
    self.commentArr = [NSMutableArray array];

    [self data];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 2;
    }
    if (1 == section) {
        return _contentArr.count;
    }
    if (2 == section) {
        return 1;
    }
    // 热门评论
    if (3 == section) {
        if (_commentArr.count >= 8) {
            return 8;
        }
        return _commentArr.count;
    }
    // 更多评论
    if (4 == section) {
        return _commentArr.count - 8;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 30;
    }
    if (2 == section) {
        return 20;
    }
    if (3 == section) {
        return 20;
    }
    if (4 == section) {
        return 20;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            return 80;
        }
        if (1 == indexPath.row) {
            return 40;
        }
    }
    // cell自适应文本高度
    if (1 == indexPath.section) {
        NSString *info = _contentArr[indexPath.row];
        CGSize infoSize = CGSizeMake(SCREEN_WIDTH, 1000);
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
        CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        return ceil(infoRect.size.height);
    }
    return 130;
}

// 自定义分区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (2 == section) {
        MovieTargetSectionHeaderView *view = [[[MovieTargetSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)] autorelease];
        view.delegate = self;
        return view;
    }
    return 0;
}

// 协议实现方法
- (void)getButtonTag:(NSInteger)tag {
    self.buttonTag = tag;
    [_movieTableView reloadData];
}

// 设置分区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return @"电影故事";
    } else if (3 == section) {
        return @"评论列表";
    } else if (4 == section) {
        return @"                                       以上是热门评论";
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        // 电影故事的作者信息
        if (0 == indexPath.row) {
            MovieInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
            if (nil == cell) {
                cell = [[[MovieInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"infoCell"] autorelease];
                cell.movieStoryArr = _movieStoryArr;
            }
            cell.movieInfoModel = _movieInfoModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 电影标题
        if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            if (nil == cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"] autorelease];
            }
            MovieStoryModel *movieStoryModel = _movieStoryArr[0];
            cell.textLabel.text = movieStoryModel.title;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    // 电影故事
    if (1 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"contentCell%ld", indexPath.row]];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"contentCell%ld", indexPath.row]] autorelease];
        }
        cell.textLabel.text = _contentArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    // 自定义cell 显示电影关键字,剧照,电影信息等内容
    if (2 == indexPath.section) {
        TargetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"target"];
        if (nil == _targetCell) {
            cell = [[[TargetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"target"] autorelease];
        }
        // 判断点击的是哪个button
        if (1010 == _buttonTag) {
            cell.targetArr = _targetArr;
            [cell displayWithMode:TargetMode];
        } else if (1011 == _buttonTag) {
            cell.pictureArr = _movieInfoModel.photo;
            [cell displayWithMode:PictureMode];
        } else {
            cell.actorInfoLabel.text = _movieInfoModel.info;
            [cell displayWithMode:ActorMode];
        }
        
        return cell;
        
    }
    if (3 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"hot%@%ld", movieCell, indexPath.row]];
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"hot%@%ld", movieCell, indexPath.row]] autorelease];
        }
        CommentModel *commentModel = _commentArr[indexPath.row];
        cell.commentModel = commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld", movieCell, indexPath.row]];
    if (nil == cell) {
        cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%ld", movieCell, indexPath.row]] autorelease];
    }
    CommentModel *commentModel = _commentArr[indexPath.row + 8];
    cell.commentModel = commentModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)getView {
    self.movieTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _movieTableView.delegate = self;
    _movieTableView.dataSource = self;
    _movieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_movieTableView];
    [_movieTableView release];
    _movieTableView.contentOffset = CGPointMake(0, -SCREEN_HEIGHT / 4);
    _movieTableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT / 4, 0, 0, 0);

    // 顶部图片
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT / 4, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
    topImageView.userInteractionEnabled = YES;
    [topImageView xl_setImageWithURL:[NSURL URLWithString:_movieInfoModel.detailcover] placeholderImage:[UIImage imageNamed:@"28B58PICxtD_1024.png"]];
    [_movieTableView addSubview:topImageView];
    [topImageView release];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [topImageView addGestureRecognizer:tap];
    [tap release];
    
    // 上滑加载
    _movieTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
    
}
// 点击顶部图片播放预告片
- (void)tapAction {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Play" object:nil];
    
    // 创建已经封装好的BH_AVPlayerView类
    self.playerView = [[BH_AVPlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.3)];
    [self.view addSubview:_playerView];
    // 路径
    _playerView.playerUrl = [NSURL URLWithString:_movieInfoModel.video];
    // 播放
    [_playerView play];
    
    // 注册一个监听屏幕切换的通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statuesBarChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    // 退出播放按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(SCREEN_WIDTH - 25, 5, 20, 20);
    [_backButton setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
    [_playerView addSubview:_backButton];
    [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backButtonAction {
    // 暂停播放
    [_playerView pause];
    // 将播放器图层移除
    [_playerView removeFromSuperview];
}
// 监听事件
- (void)statuesBarChanged:(NSNotification *)sender{
    // 切换屏幕方向
    UIInterfaceOrientation statues = [UIApplication sharedApplication].statusBarOrientation;
    // 如果Home键向下(默认情况)或者是向上
    if (statues == UIInterfaceOrientationPortrait || statues == UIInterfaceOrientationPortraitUpsideDown) {
        _playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.3);
        // 屏幕方向改变同时改变退出按钮的frame
        _backButton.frame = CGRectMake(SCREEN_WIDTH - 25, 5, 20, 20);
        [_backButton setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
        [_playerView addSubview:_backButton];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    // 如果Home键靠左或者靠右
    }else if (statues == UIInterfaceOrientationLandscapeLeft || statues == UIInterfaceOrientationLandscapeRight){
        _playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [_backButton removeFromSuperview];
    }
}

// 加载
- (void)Loading {
    [self commentData];
    [_movieTableView reloadData];
    [_movieTableView.mj_footer endRefreshing];
}

- (void)commentData {
    CommentModel *commentModel = [_commentArr lastObject];
    self.commentNumber = commentModel.ID;
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/movie/%@/%@", _movieModel.movieID, _commentNumber] success:^(id result) {
        NSDictionary *tempDic = [result objectForKey:@"data"];
        NSArray *dataArr = [tempDic objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
            [_commentArr addObject:commentModel];
        }
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [_playerView pause];
}
- (void)data {
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/movie/detail/" mutableCopy];
    [urlString appendString:_movieModel.movieID];

    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        self.movieInfoModel = [MovieInfoModel mj_objectWithKeyValues:dataDic];
        self.targetArr = [_movieInfoModel.keywords componentsSeparatedByString:@";"];
//        NSLog(@"%@", _targetArr);
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
    
    NSString *urlString2 = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/%@/story/1/0", _movieModel.movieID];
    [HttpClient GETWithURLString:urlString2 success:^(id result) {

        NSDictionary *tempData = [result objectForKey:@"data"];
        NSArray *dataArr = [tempData objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            MovieStoryModel *movieStoryModel = [MovieStoryModel mj_objectWithKeyValues:dataDic];
            [_movieStoryArr addObject:movieStoryModel];
            NSString *content = [dataDic objectForKey:@"content"];
            self.contentArr = [content componentsSeparatedByString:@"\r\n"];

        }
        // 网络请求完成后加载视图
        [self getView];
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
    
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/movie/%@/0", _movieModel.movieID] success:^(id result) {
        NSDictionary *tempDic = [result objectForKey:@"data"];
        NSArray *dataArr = [tempDic objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
            [_commentArr addObject:commentModel];
        }
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
