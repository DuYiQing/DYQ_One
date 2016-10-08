//
//  QuestionCollectionViewCell.h
//  DYQ_One
//
//  Created by DYQ on 16/10/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@class QuestionInfoModel;

@interface QuestionCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) QuestionInfoModel *questionInfoModel;
@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, retain) NSArray *commentArr;

@end
