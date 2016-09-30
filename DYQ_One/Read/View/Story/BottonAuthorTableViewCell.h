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
@class CommentModel;

@interface BottonAuthorTableViewCell : UITableViewCell

@property (nonatomic, retain) NovelModel *novelModel;
@property (nonatomic, retain) SerialModel *serialModel;
//@property (nonatomic, retain) NSArray *commentArr;
@property (nonatomic, assign) long currentRow;
@property (nonatomic, retain) CommentModel *commentModel;

@end
