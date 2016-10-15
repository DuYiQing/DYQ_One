//
//  SearchViewController.m
//  DYQ_One
//
//  Created by DYQ on 16/10/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SearchViewController.h"
#import "UIButton+Block.h"
#import "HttpClient.h"
#import "SearchTableViewCell.h"
#import "HPModel.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"

@interface SearchViewController ()
<
UISearchBarDelegate,
UISearchControllerDelegate,
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UISearchController *searchController;
@property (nonatomic, retain) UITableView *resultTableView;
@property (nonatomic, retain) NSArray *resultArray;
@property (nonatomic, retain) HPModel *hpModel;
@property (nonatomic, retain) NSMutableArray *hpModelArr;
@property (nonatomic, retain) UILabel *noResultLabel;
@property (nonatomic, retain) UIImageView *noResultImageView;
@property (nonatomic, retain) UIImageView *placeholderImage;
@property (nonatomic, retain) UICollectionView *searchCollectionView;

@end

@implementation SearchViewController

- (void)dealloc {
    [_searchController release];
    [_resultTableView release];
    [_resultArray release];
    [_hpModel release];
    [_hpModelArr release];
    [_noResultLabel release];
    [_noResultImageView release];
    [_placeholderImage release];
    [_searchCollectionView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.hpModelArr = [NSMutableArray array];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    UISearchBar *searchBar = _searchController.searchBar;
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;

    [[[searchBar.subviews objectAtIndex:0].subviews objectAtIndex:1] setBackgroundColor:[UIColor colorWithRed:0.8619 green:0.8619 blue:0.8619 alpha:1.0]];
    searchBar.placeholder = @"输入搜索内容";

    self.navigationItem.titleView = searchBar;
    self.navigationItem.hidesBackButton = YES;
    
    self.placeholderImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) / 2, SCREEN_HEIGHT / 3, 60, 60)];
    _placeholderImage.image = [UIImage imageNamed:@"search.png"];
    [self.view addSubview:_placeholderImage];
    [_placeholderImage release];
}
- (void)getTableView {
    self.resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _resultTableView.delegate = self;
    _resultTableView.dataSource = self;
    _resultTableView.rowHeight = 80;
    _resultTableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self.view addSubview:_resultTableView];
    [_resultTableView release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hpModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"search%ld", indexPath.row]];
    if (cell == nil) {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"search%ld", indexPath.row]];
    }
    cell.hpModel = _hpModelArr[indexPath.row];
    return cell;
}
- (void)noResult {
    _placeholderImage.hidden = YES;
    self.noResultImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) / 2, SCREEN_HEIGHT / 3, 60, 60)];
    _noResultImageView.image = [UIImage imageNamed:@"without.png"];
    [self.view addSubview:_noResultImageView];
    [_noResultImageView release];
    
    self.noResultLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, _noResultImageView.center.y + _noResultImageView.bounds.size.height / 2 + 10, 200, 40)];
    _noResultLabel.text = @"暂无相关搜索结果~";
    _noResultLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_noResultLabel];
    [_noResultLabel release];
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    [_resultTableView removeFromSuperview];
    _placeholderImage.hidden = NO;
    _noResultImageView.hidden = YES;
    _noResultLabel.hidden = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *string = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/search/hp/%@", searchBar.text];
    NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"%@", url] success:^(id result) {
        [_hpModelArr removeAllObjects];
        self.resultArray = [result objectForKey:@"data"];
        if (_resultArray.count == 0) {
            [self noResult];
        } else {
            for (NSDictionary *resultDic in _resultArray) {
                self.hpModel = [HPModel mj_objectWithKeyValues:resultDic];
                [_hpModelArr addObject:_hpModel];
            }
            [self getTableView];
            [_resultTableView reloadData];
        }
    } failure:^(id error) {
        [self noResult];
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
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
