//
//  ColorfulViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ColorfulViewController.h"
#import "HttpClient.h"
#import "ColorfulViewModel.h"
#import "ColorfulTableViewCell.h"
#import "UIImageView+XLWebCache.h"
#import "UIImage+Categories.h"
#import "UIColor+Categories.h"

static NSString *const tableViewCell = @"cell";

@interface ColorfulViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) NSMutableArray *colorfulArr;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIImageView *footerImageView;
@property (nonatomic, retain) UIColor *bgColor;

@end

@implementation ColorfulViewController

- (void)dealloc {
    [_colorfulArr release];
    [_tableView release];
    [_backButton release];
    [_footerImageView release];
    [_bgColor release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.colorfulArr = [NSMutableArray array];

    [self data];
    self.bgColor = [UIColor colorWithHexString:_backgroundColor andAlpha:1.0f];
    self.view.backgroundColor = _bgColor;
}

- (void)getView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = _bgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(30, 0, 20, 0);
    _tableView.rowHeight = 130;
    [self.view addSubview:_tableView];
    [_tableView release];

    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(15, 30, 15, 15);
    [_backButton setImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, _tableView.bounds.size.width, 50)];
//    headerLabel.backgroundColor = [UIColor redColor];
    headerLabel.text = _top_text;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textColor = [UIColor whiteColor];
    [_tableView beginUpdates];
    _tableView.tableHeaderView = headerLabel;
    [_tableView endUpdates];
    [headerLabel release];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, SCREEN_HEIGHT)];
    footerView.backgroundColor = _bgColor;
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT / 3, SCREEN_WIDTH - 60, 40)];
//    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = _bottom_text;
    footerLabel.font = kFONT_SIZE_18_BOLD;
    footerLabel.numberOfLines = 0;
    [footerLabel sizeToFit];
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:footerLabel];
    [footerLabel release];
    
    self.footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 4 * 3, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
    [_footerImageView xl_setImageWithURL:[NSURL URLWithString:_imageURLString] placeholderImage:nil];
    [footerView addSubview:_footerImageView];
    [_footerImageView release];
    
    
    [_tableView beginUpdates];
    _tableView.tableFooterView = footerView;
    [_tableView endUpdates];
    [footerView release];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.contentSize.height - SCREEN_HEIGHT + 20;

    CGFloat imageHeight = SCREEN_HEIGHT / 4 + (scrollView.contentOffset.y - height);
    CGFloat scale = (SCREEN_HEIGHT / 4) / SCREEN_WIDTH;
    
    if (scrollView.contentOffset.y >= height) {
        _footerImageView.frame = CGRectMake(-((imageHeight / scale) - SCREEN_WIDTH) / 2, SCREEN_HEIGHT / 4 * 3, imageHeight / scale, imageHeight);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _colorfulArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorfulTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (nil == cell) {
        cell = [[[ColorfulTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell] autorelease];
        cell.colorfulModel = _colorfulArr[indexPath.row];
    }

    cell.backgroundColor = _bgColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)data {
    
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/reading/carousel/" mutableCopy];
    [urlString appendString:_imageId];
    [HttpClient GETWithURLString:urlString success:^(id result) {

        NSArray *dataArr = [result objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            ColorfulViewModel *colorfulViewModel = [ColorfulViewModel modelWithDic:dataDic];
            [_colorfulArr addObject:colorfulViewModel];
        }
        [self getView];
        [_tableView reloadData];
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
}


- (void)backButtonAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
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
