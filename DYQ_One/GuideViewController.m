//
//  GuideViewController.m
//  DYQ_One
//
//  Created by DYQ on 16/10/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "GuideViewController.h"
#import "RootViewController.h"

@interface GuideViewController ()
<
UIScrollViewDelegate
>
@property (nonatomic, retain) UIPageControl *pageControl;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *guideScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    for (int i = 1; i <= 4; i++) {
        
         NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", i] ofType:@"gif"]];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH  * (i - 1), 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        webView.userInteractionEnabled = NO;
        [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (i - 1), 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.gif",i]];
        if (4 == i) {
//            imageView.userInteractionEnabled = YES;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 7 / 8, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            
            // 设置圆角
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            // 设置边框颜色
            button.layer.borderColor = [UIColor cyanColor].CGColor;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [webView addSubview:button];
        }
        [guideScrollView addSubview:webView];
    }
    guideScrollView.pagingEnabled = YES;
    // 关闭回弹效果
    guideScrollView.bounces = NO;
    
    guideScrollView.showsHorizontalScrollIndicator = NO;
    guideScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    guideScrollView.delegate = self;
    [self.view addSubview:guideScrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16 * 15, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16)];
    _pageControl.numberOfPages = 4;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.2377 green:0.7966 blue:0.9988 alpha:0.59];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.6365 green:0.8182 blue:1.0 alpha:1.0];
    [self.view addSubview:_pageControl];
    
}

- (void)buttonAction:(UIButton *)button {
    
//    flag = YES;
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    [userDef setBool:flag forKey:@"notFirst"];
//    [userDef synchronize];
    
    self.view.window.rootViewController = [[RootViewController alloc] init];
    
}

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
