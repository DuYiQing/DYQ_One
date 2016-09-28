//
//  MovieTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@class MovieModel;

@interface MovieTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieModel *movieModel;

@end
