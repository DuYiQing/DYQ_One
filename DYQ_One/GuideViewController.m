//
//  GuideViewController.m
//  DYQ_One
//
//  Created by DYQ on 16/10/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "GuideViewController.h"
#import "RootViewController.h"
#import "UIImage+GIF.h"
#import "SDImageCache.h"
#import "RootViewController.h"
#import "ReadViewController.h"
#import "MusicViewController.h"
#import "MovieViewController.h"
#import "RootTabBarViewController.h"

@interface GuideViewController ()
<
UIScrollViewDelegate,
UITabBarControllerDelegate
>
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL flag;


@end

@implementation GuideViewController
- (void)dealloc {
    [_pageControl release];
//    [_rootTabBarController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.view.backgroundColor = [UIColor colorWithRed:0.9765 green:0.9843 blue:1.0 alpha:1.0];
        
        UIScrollView *guideScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        for (int i = 1; i < 5; i++) {
            // 用SDWebImage加载GIF格式的图片
            NSString  *name = [NSString stringWithFormat:@"%d.gif", i];
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
            NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (i - 1), SCREEN_HEIGHT / 6, SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2)];
            imageView.image = [UIImage sd_animatedGIFWithData:imageData];
            
            if (4 == i) {
                imageView.userInteractionEnabled = YES;
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(SCREEN_WIDTH / 3, imageView.bounds.size.height / 8 * 7, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16);
                [button setTitle:@"进入 ONE 3.0" forState:UIControlStateNormal];
                
                // 设置圆角
                button.layer.borderWidth = 1;
                button.layer.cornerRadius = 5;
                button.clipsToBounds = YES;
                // 设置边框颜色
                button.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:button];
            }
            [guideScrollView addSubview:imageView];
        }
        guideScrollView.pagingEnabled = YES;
        // 关闭回弹效果
        guideScrollView.bounces = NO;
        
        guideScrollView.showsHorizontalScrollIndicator = NO;
        guideScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT);
        guideScrollView.delegate = self;
        [self.view addSubview:guideScrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16 * 15, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16)];
        _pageControl.numberOfPages = 4;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.3596 green:0.4874 blue:0.6305 alpha:1.0];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self.view addSubview:_pageControl];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

- (void)buttonAction:(UIButton *)button {
    
//    self.flag = YES;
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    [userDef setBool:_flag forKey:@"notFirst"];
//    [userDef synchronize];
    RootTabBarViewController *rootTabBarController = [[RootTabBarViewController alloc] init];
    self.view.window.rootViewController = rootTabBarController;
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [rootTabBarController release];

}
// pageController与轮播图关联
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x) / [UIScreen mainScreen].bounds.size.width;
    
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
