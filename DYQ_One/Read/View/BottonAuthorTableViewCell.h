//
//  BottonAuthorTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "InfoBaseTableViewCell.h"
@class NovelModel;
@class SerialModel;

@interface BottonAuthorTableViewCell : UITableViewCell

@property (nonatomic, retain) NovelModel *novelModel;
@property (nonatomic, retain) SerialModel *serialModel;

@end
