//
//  MusicCollectionViewCell.h
//  DYQ_One
//
//  Created by DYQ on 16/9/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicModel;
@class CommentModel;

@interface MusicCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) MusicModel *musicModel;
@property (nonatomic, retain) NSArray *storyArr;
@property (nonatomic, retain) CommentModel *commentModel;
@property (nonatomic, retain) NSArray *commentArr;

@end
