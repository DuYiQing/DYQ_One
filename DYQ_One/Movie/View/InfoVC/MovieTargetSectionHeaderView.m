//
//  MovieTargetSectionHeaderView.m
//  DYQ_One
//
//  Created by DYQ on 16/10/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieTargetSectionHeaderView.h"

@interface MovieTargetSectionHeaderView ()

@property (nonatomic, retain) UIButton *keyWordsButton;
@property (nonatomic, retain) UIButton *pictureButton;
@property (nonatomic, retain) UIButton *actorsButton;
@property (nonatomic, retain) NSMutableArray *imageArr;

@end

@implementation MovieTargetSectionHeaderView

- (void)dealloc {
    [_keyWordsButton release];
    [_pictureButton release];
    [_actorsButton release];
    [_imageArr release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageArr = [NSMutableArray array];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -10, 80, 30)];
        titleLabel.text = @"一个 电影表";
        titleLabel.font = kFONT_SIZE_12_BOLD;
        titleLabel.textColor = [UIColor grayColor];
        [self addSubview:titleLabel];
        [titleLabel release];

        // 关键字按钮
        self.keyWordsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _keyWordsButton.frame = CGRectMake(SCREEN_WIDTH / 2, -10, 30, 30);
        [_keyWordsButton setImage:[UIImage imageNamed:@"keywords.png"] forState:UIControlStateNormal];
        _keyWordsButton.tag = 1010;
        [self addSubview:_keyWordsButton];
        [_keyWordsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 剧照轮播图按钮
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pictureButton.frame = CGRectMake(SCREEN_WIDTH / 6 * 4, -10, 30, 30);
        [_pictureButton setImage:[UIImage imageNamed:@"picture.png"] forState:UIControlStateNormal];
        _pictureButton.tag = 1011;
        [self addSubview:_pictureButton];
        [_pictureButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 演职人员信息按钮
        self.actorsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actorsButton.frame = CGRectMake(SCREEN_WIDTH / 6 * 5, -10, 30, 30);
        [_actorsButton setImage:[UIImage imageNamed:@"actors.png"] forState:UIControlStateNormal];
        _actorsButton.tag = 1012;
        [self addSubview:_actorsButton];
        [_actorsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    return self;
}
// 点击三个按钮调用同一个点击事件
- (void)buttonAction:(UIButton *)button {
    // 点击按钮调用协议
    [self.delegate getButtonTag:button.tag];
}

@end
