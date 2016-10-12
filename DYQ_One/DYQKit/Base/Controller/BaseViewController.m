//
//  BaseViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseViewController.h"
#import "UserViewController.h"
#import "SearchViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Unknown.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Unknown-1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];

    
}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButton {
    NSLog(@"搜索");
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self presentViewController:searchVC animated:YES completion:nil];
    [searchVC release];
}
- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButton {
    UserViewController *userVC = [[UserViewController alloc] init];
    [self.navigationController pushViewController:userVC animated:YES];
    [userVC release];
}
- (void)viewWithoutNetRequest {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80) / 2, SCREEN_HEIGHT / 4, 80, 80)];
    imageView.image = [UIImage imageNamed:@"without.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, imageView.frame.origin.y + imageView.bounds.size.height + 20, 200, 40)];
    label.text = @"请检查网络设置";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label release];
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
