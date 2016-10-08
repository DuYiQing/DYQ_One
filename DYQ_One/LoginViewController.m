//
//  LoginViewController.m
//  DYQ_One
//
//  Created by DYQ on 16/10/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LoginViewController.h"
#import "UIImage+Categories.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"20150721082414_SVYji.thumb.700_0.jpeg"];
    backgroundImageView.image = [backgroundImageView.image boxblurImageWithBlur:0.7f];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"tc.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.center = CGPointMake(self.view.center.x, backButton.center.y);
    titleLabel.text = @"登录ONE";
    titleLabel.font = kFONT_SIZE_18_BOLD;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    UIButton *wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatButton.frame = CGRectMake(50, 120, SCREEN_WIDTH - 100, 40);
    wechatButton.backgroundColor = [UIColor colorWithRed:0.8616 green:0.8616 blue:0.8616 alpha:1.0];
    [wechatButton setTitle:@"微信" forState:UIControlStateNormal];
    wechatButton.layer.cornerRadius = 3.f;
    [self.view addSubview:wechatButton];
    

    
    UIImageView *wechatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    wechatImageView.image = [UIImage imageNamed:@"WeChat.png"];
    [wechatButton addSubview:wechatImageView];
    [wechatImageView release];
    
    UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboButton.frame = CGRectMake(50, 170, wechatButton.bounds.size.width, wechatButton.bounds.size.height);
    weiboButton.backgroundColor = [UIColor colorWithRed:0.8616 green:0.8616 blue:0.8616 alpha:1.0];
    [weiboButton setTitle:@"微博" forState:UIControlStateNormal];
    weiboButton.layer.cornerRadius = 3.f;
    [self.view addSubview:weiboButton];
    
    UIImageView *weiboImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    weiboImageView.image = [UIImage imageNamed:@"weibo.png"];
    [weiboButton addSubview:weiboImageView];
    [weiboImageView release];
    
    UIButton *QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QQButton.frame = CGRectMake(50, 220, wechatButton.bounds.size.width, wechatButton.bounds.size.height);
    QQButton.backgroundColor = [UIColor colorWithRed:0.8616 green:0.8616 blue:0.8616 alpha:1.0];
    [QQButton setTitle:@"QQ" forState:UIControlStateNormal];
    QQButton.layer.cornerRadius = 3.f;
    [self.view addSubview:QQButton];
    
    UIImageView *QQImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 9, 24, 24)];
    QQImageView.image = [UIImage imageNamed:@"QQ.png"];
    [QQButton addSubview:QQImageView];
    [QQImageView release];
    
    UILabel *orLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    orLabel.center = CGPointMake(wechatButton.center.x, QQButton.frame.origin.y + QQButton.bounds.size.height + 20);
    orLabel.text = @"或者";
    orLabel.textAlignment = NSTextAlignmentCenter;
    orLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:orLabel];
    [orLabel release];
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(QQButton.frame.origin.x, orLabel.frame.origin.y + orLabel.bounds.size.height, QQButton.bounds.size.width, QQButton.bounds.size.height);
    [phoneButton setTitle:@"使用手机号登录" forState:UIControlStateNormal];
    [phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:phoneButton];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 5, 30, 30)];
    phoneImageView.image = [UIImage imageNamed:@"phone.png"];
    [phoneButton addSubview:phoneImageView];
    [phoneImageView release];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2, SCREEN_HEIGHT - 80, 150, 60)];
    bottomLabel.text = @"创建账号即代表您同意使用条款和隐私条约";
    bottomLabel.numberOfLines = 0;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.font = kFONT_SIZE_15_BOLD;
    [self.view addSubview:bottomLabel];
    [bottomLabel release];
    
}

- (void)backAction:(UIButton *)button {
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
