//
//  MovieInfoTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieInfoModel;
@class MovieStoryModel;

@interface MovieInfoTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieInfoModel *movieInfoModel;
@property (nonatomic, retain) MovieStoryModel *movieStoryModel;
@property (nonatomic, retain) NSArray *movieStoryArr;

@end
