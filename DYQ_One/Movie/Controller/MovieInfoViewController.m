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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.movieStoryArr = [NSMutableArray array];
    self.contentArr = [NSMutableArray array];
    [self data];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 2;
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
    MovieStoryModel *movieStoryModel = _movieStoryArr[0];
    if ((0 == indexPath.section) && (2 == indexPath.row)) {
        NSString *info = movieStoryModel.content;
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
    if (2 == section) {
        return @"一个电影表";
    }
    if (3 == section) {
        return @"评论列表";
    }
    if ()
    
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
        if (2 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
            if (nil == cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentCell"];
            }
            MovieStoryModel *movieStoryModel = _movieStoryArr[0];
            cell.textLabel.text = movieStoryModel.content;
            return cell;

        }
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
    _movieTableView.rowHeight = 80;
    [self.view addSubview:_movieTableView];
    [_movieTableView release];
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
            _contentArr = [content componentsSeparatedByString:@"\r\n"];

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
