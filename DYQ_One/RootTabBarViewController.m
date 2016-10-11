//
//  RootTabBarViewController.m
//  DYQ_One
//
//  Created by DYQ on 16/10/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RootViewController.h"
#import "ReadViewController.h"
#import "MusicViewController.h"
#import "MovieViewController.h"

@interface RootTabBarViewController ()
<
UITabBarControllerDelegate
>
@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 首页
    RootViewController *rootVC = [[RootViewController alloc] init];
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootNavigationController.navigationBar.translucent = NO;
    UIImage *rootImage = [UIImage imageNamed:@"Unknown-2.png"];
    rootImage = [rootImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *rootSelectedImage = [UIImage imageNamed:@"Unknown-3.png"];
    rootSelectedImage = [rootSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:rootImage selectedImage:rootSelectedImage];
    
    // 阅读
    ReadViewController *readVC = [[ReadViewController alloc] init];
    UINavigationController *readNavigationController = [[UINavigationController alloc] initWithRootViewController:readVC];
    readNavigationController.navigationBar.translucent = NO;
    UIImage *readImage = [UIImage imageNamed:@"Unknown-4.png"];
    readImage = [readImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *readSelectedImage = [UIImage imageNamed:@"Unknown-5.png"];
    readSelectedImage = [readSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    readNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"阅读" image:readImage selectedImage:readSelectedImage];
    
    // 音乐
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    UINavigationController *musicNavigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    musicNavigationController.navigationBar.translucent = NO;
    UIImage *musicImage = [UIImage imageNamed:@"Unknown-6.png"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *musicSelectedImage = [UIImage imageNamed:@"Unknown-7.png"];
    musicSelectedImage = [musicSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"音乐" image:musicImage selectedImage:musicSelectedImage];
    
    //电影
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    UINavigationController *movieNavigationController = [[UINavigationController alloc] initWithRootViewController:movieVC];
    movieNavigationController.navigationBar.translucent = NO;
    UIImage *movieImage = [UIImage imageNamed:@"Unknown-8.png"];
    movieImage = [movieImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *movieSelectedImage = [UIImage imageNamed:@"Unknown-9.png"];
    movieSelectedImage = [movieSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    movieNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:movieImage selectedImage:movieSelectedImage];
    
    // 标签视图控制器
    self.viewControllers = @[rootNavigationController, readNavigationController, musicNavigationController, movieNavigationController];
    self.delegate = self;
    self.tabBar.tintColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    
    [rootVC release];
    [rootNavigationController release];
    [readVC release];
    [readNavigationController release];
    [musicVC release];
    [musicNavigationController release];
    [movieVC release];
    [movieNavigationController release];

    
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
