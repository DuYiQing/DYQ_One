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

static NSString *const movieCell = @"movieCell";

@interface MovieViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) NSMutableArray *movieArr;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"电影";
    
    self.movieArr = [NSMutableArray array];
    
    
    [self data];

}

- (void)getView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = SCREEN_HEIGHT / 4;
    [self.view addSubview:_tableView];
    [_tableView release];
}

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
        cell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieCell];
    }
    MovieModel *movieModel = _movieArr[indexPath.row];
    cell.movieModel = movieModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)data {
    [HttpClient GETWithURLString:@"http://v3.wufazhuce.com:8000/api/movie/list/0" success:^(id result) {

        NSArray *dataArr = [result objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            MovieModel *movieModel = [MovieModel mj_objectWithKeyValues:dataDic];
            [_movieArr addObject:movieModel];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
