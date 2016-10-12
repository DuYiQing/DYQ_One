//
//  MovieTargetSectionHeaderView.h
//  DYQ_One
//
//  Created by DYQ on 16/10/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

// 协议 获取点击的Button的tag值
@protocol MovieTargetSectionHeaderViewDelegate <NSObject>

- (void)getButtonTag:(NSInteger)tag;

@end

@interface MovieTargetSectionHeaderView : UIView

@property (nonatomic, assign) id<MovieTargetSectionHeaderViewDelegate>delegate;

@end
