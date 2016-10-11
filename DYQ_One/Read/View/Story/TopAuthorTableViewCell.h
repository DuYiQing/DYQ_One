//
//  TopAuthorTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NovelModel;
@class SerialModel;


@interface TopAuthorTableViewCell : UITableViewCell

@property (nonatomic, retain) NovelModel *novelModel;
@property (nonatomic, retain) SerialModel *serialModel;
@property (nonatomic, assign) BOOL isPlaying;

@end
