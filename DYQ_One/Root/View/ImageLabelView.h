//
//  ImageLabelView.h
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootModel;

@interface ImageLabelView : UIView

@property (nonatomic, retain) RootModel *rootModel;
@property (nonatomic, retain) UIImageView *topImageView;
@property (nonatomic, retain) UILabel *volLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@end
