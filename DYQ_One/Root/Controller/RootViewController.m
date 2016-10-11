//
//  RootViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RootViewController.h"

#import "HttpClient.h"
#import "DYQBaseModel.h"
#import "RootModel.h"
#import "ImageLabelView.h"
#import "LikeView.h"
#import "LoginViewController.h"
#import "MJRefresh.h"

static NSString *const rootCell = @"rootCell";

@interface RootViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate
>

@property (nonatomic, retain) NSMutableArray *rootDataArr;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIScrollView *rootScrollView;
@property (nonatomic, retain) NSMutableArray *scrollViewArr;

@end

@implementation RootViewController

- (void)dealloc {
    [_rootDataArr release];
    [_scrollViewArr release];
    [_tableView release];
    [_rootScrollView release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.title = @"ONE";
    self.rootDataArr = [NSMutableArray array];
    self.scrollViewArr = [NSMutableArray array];

    [self data];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rootCell];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rootCell] autorelease];
        }
        return cell;
    
}

- (void)buttomOfView {
    UIImageView *noteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 560, 20, 20)];
    noteImageView.image = [UIImage imageNamed:@"Unknown-10.png"];
    [self.view addSubview:noteImageView];
    [noteImageView release];

    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(noteImageView.frame.origin.x + noteImageView.bounds.size.width + 5, noteImageView.frame.origin.y, 30, 20)];
    noteLabel.text = @"小记";
    noteLabel.userInteractionEnabled = YES;
    noteLabel.textColor = [UIColor lightGrayColor];
    noteLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:noteLabel];
    [noteLabel release];
    
    UITapGestureRecognizer *noteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [noteLabel addGestureRecognizer:noteTap];
    [noteTap release];
    
    RootModel *rootModel = _rootDataArr[0];
    LikeView *likeView = [[LikeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, noteImageView.frame.origin.y, 100, 40)];
    likeView.numLabel.text = [NSString stringWithFormat:@"%@", rootModel.praisenum ];
    [self.view addSubview:likeView];
    [likeView release];
    
    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [likeView addGestureRecognizer:likeTap];
    [likeTap release];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(SCREEN_WIDTH  - 50, noteImageView.frame.origin.y - 5, 20, 30);
    [shareButton setImage:[UIImage imageNamed:@"Unknown-13.png"] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shareButtonAction {
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"share"] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypeSaveToCameraRoll, UIActivityTypePrint];
    [self presentViewController:activityVC animated:YES completion:nil];
    [activityVC release];
}


- (void)tapAction {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
    [loginVC release];
}

- (void)setView {
    self.tableView = [[UITableView alloc] initWithFrame:SCREEN_RECT style:UITableViewStylePlain];
    _tableView.rowHeight = SCREEN_HEIGHT;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 550)];
    _rootScrollView.contentSize = CGSizeMake(_rootScrollView.bounds.size.width * _rootDataArr.count, _rootScrollView.bounds.size.height);
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.delegate = self;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    [_tableView addSubview:_rootScrollView];
    [_rootScrollView release];
    
    
    _tableView.rowHeight = _rootScrollView.bounds.size.height;
    
    for (int i = 0; i < _rootDataArr.count; i++) {
        ImageLabelView *imageLabelView = [[ImageLabelView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH + 10 , 10, SCREEN_WIDTH - 20, 400)];
        imageLabelView.rootModel = _rootDataArr[i];
        [_rootScrollView addSubview:imageLabelView];
        [imageLabelView release];
    }
    
    [self buttomOfView];
    
}

- (void)data {
    [HttpClient GETWithURLString:@"http://v3.wufazhuce.com:8000/api/hp/more/0" success:^(id result) {
//        NSLog(@"result : %@", result);
        NSArray *dataArray = [result objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArray) {
            RootModel *rootModel = [RootModel modelWithDic:dataDic];
            [_rootDataArr addObject:rootModel];
            
        }
        
        [self setView];
//        NSLog(@"%@", _rootDataArr);
    } failure:^(id error) {
        NSLog(@"error :%@", error);
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
