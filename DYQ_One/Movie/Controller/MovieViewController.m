//
//  MovieViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieViewController.h"
#import "HttpClient.h"
#import "MovieModel.h"
#import "MJExtension.h"
#import "MovieTableViewCell.h"
#import "MovieInfoViewController.h"
#import "MJRefresh.h"

static NSString *const movieCell = @"movieCell";

@interface MovieViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) NSMutableArray *movieArr;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, copy) NSString *movieID;

@end

@implementation MovieViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)dealloc {
    [_movieArr release];
    [_movieID release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"电影";
    self.movieArr = [NSMutableArray array];
    self.movieID = 0;
    [self data];

}

- (void)Loading {
    MovieModel *movieModel = [_movieArr lastObject];
    _movieID = movieModel.movieID;
    [self refreshMovieList];
    [_tableView reloadData];
    [_tableView.mj_footer endRefreshing];
}

- (void)refreshMovieList {

    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/list/%@", _movieID] success:^(id result) {
        
        NSArray *dataArr = [result objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            MovieModel *movieModel = [MovieModel mj_objectWithKeyValues:dataDic];
            [_movieArr addObject:movieModel];
        }
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];

}

- (void)getView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = SCREEN_HEIGHT / 4;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
}

// 点击tableView的cell跳转到相应的电影信息页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieInfoViewController *movieInfoVC = [[MovieInfoViewController alloc] init];
    [self.navigationController pushViewController:movieInfoVC animated:YES];
    MovieModel *movieModel = _movieArr[indexPath.row];
    movieInfoVC.movieModel = movieModel;
    
    [movieInfoVC release];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _movieArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCell];
    if (nil == cell) {
        cell = [[[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieCell] autorelease];
    }
    MovieModel *movieModel = _movieArr[indexPath.row];
    cell.movieModel = movieModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)data {
    [SVProgressHUD showImage:[UIImage imageNamed:@"robot.png"] status:@"加载中,请稍后..."];
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/list/%@", _movieID] success:^(id result) {
        NSArray *dataArr = [result objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            MovieModel *movieModel = [MovieModel mj_objectWithKeyValues:dataDic];
            [_movieArr addObject:movieModel];
        }
        [self getView];
        [SVProgressHUD dismiss];
    } failure:^(id error) {
        [self viewWithoutNetRequest];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
