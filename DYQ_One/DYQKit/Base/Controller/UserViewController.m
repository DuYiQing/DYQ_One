//
//  UserViewController.m
//  DYQ_One
//
//  Created by DYQ on 16/10/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"

@interface UserViewController ()

<
UINavigationControllerDelegate,
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *topImageView;
@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated {
    // 隐藏navigationBar
    self.navigationController.navigationBarHidden = YES;
}
- (void)dealloc {
    [_tableView release];
    [_topImageView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT / 3, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(-SCREEN_HEIGHT / 3, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT / 3, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
    _topImageView.image = [UIImage imageNamed:@"usertop.jpeg"];
    [_tableView addSubview:_topImageView];
    [_topImageView release];
    
    // 返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // 头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) / 2, -SCREEN_HEIGHT / 5, 60, 60)];
    headImageView.image = [UIImage imageNamed:@"robot.png"];
    headImageView.backgroundColor = [UIColor colorWithRed:0.0938 green:0.2447 blue:0.5 alpha:0.89];
    headImageView.layer.cornerRadius = headImageView.bounds.size.width / 2;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 1.0f;
    // 打开用户交互
    headImageView.userInteractionEnabled = YES;
    [_tableView addSubview:headImageView];
    [headImageView release];
    // 给头像ImageView添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [headImageView addGestureRecognizer:tap];
    [tap release];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.frame.origin.x, headImageView.frame.origin.y +headImageView.bounds.size.height + 5, headImageView.bounds.size.width, 40)];
    loginLabel.text = @"请登录";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = kFONT_SIZE_15_BOLD;
    [_tableView addSubview:loginLabel];
    [loginLabel release];
    
}

// 点击头像跳出登录界面
- (void)tapAction:(UITapGestureRecognizer *)tap {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
    [loginVC release];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGFloat contentY = scrollView.contentOffset.y;
    // 下拉放大顶部背景图片
    if (contentY < -245) {
        _topImageView.frame = CGRectMake(0, -(SCREEN_HEIGHT / 3 - scrollView.contentOffset.y), SCREEN_WIDTH, (SCREEN_HEIGHT / 3 - scrollView.contentOffset.y));
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"设置";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"夜间模式";
        } else {
            cell.textLabel.text = @"关于我们";
        }
        return cell;
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
