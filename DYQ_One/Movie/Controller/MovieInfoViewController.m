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


static NSString *const movieCell = @"movieCell";

@interface MovieInfoViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *movieTableView;
@property (nonatomic, retain) MovieInfoModel *movieInfoModel;
@property (nonatomic, retain) NSMutableArray *movieStoryArr;
@property (nonatomic, retain) NSArray *contentArr;


@end

@implementation MovieInfoViewController

- (void)dealloc {
    [_movieTableView release];
    [_contentArr release];
    [_movieStoryArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.movieStoryArr = [NSMutableArray array];
    self.contentArr = [NSArray array];
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
    if (3 == section) {
        return 8;
    }
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (1 == indexPath.section) {
        NSString *info = _contentArr[indexPath.row];
        CGSize infoSize = CGSizeMake(SCREEN_WIDTH, 1000);
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
        CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        return ceil(infoRect.size.height);
    }
    return 80;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return @"电影故事";
    }
    if (1 == section) {
        return @"";
    }
    if (2 == section) {
        return @"一个电影表";
    }
    if (3 == section) {
        return @"评论列表";
    }
    
    return @"以上是热门评论";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            MovieInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
            if (nil == cell) {
                cell = [[MovieInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"infoCell"];
                cell.movieStoryArr = _movieStoryArr;
            }
            cell.movieInfoModel = _movieInfoModel;
            return cell;
        }
        if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            if (nil == cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            }
            MovieStoryModel *movieStoryModel = _movieStoryArr[0];
            cell.textLabel.text = movieStoryModel.title;
            return cell;
        }
    }
    if (1 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"contentCell%ld", indexPath.row]];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"contentCell%ld", indexPath.row]];
        }
        cell.textLabel.text = _contentArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        
        return cell;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCell];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieCell];
    }
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

    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT / 4, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
    [topImageView xl_setImageWithURL:[NSURL URLWithString:_movieInfoModel.detailcover] placeholderImage:nil];
    [_movieTableView addSubview:topImageView];
    [topImageView release];
    
}

- (void)data {
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/movie/detail/" mutableCopy];
    [urlString appendString:_movieModel.movieID];

    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        self.movieInfoModel = [MovieInfoModel mj_objectWithKeyValues:dataDic];

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
        [self getView];
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
