//
//  ThreeLabelView.h
//  DYQ_One
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColorfulViewModel;

@interface ThreeLabelView : UIView

@property (nonatomic, retain) ColorfulViewModel *colorfulModel;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *contentLabel;

@end
