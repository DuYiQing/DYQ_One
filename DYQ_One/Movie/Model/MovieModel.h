//
//  MovieModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"
@class MJExtension;

@interface MovieModel : DYQBaseModel

@property (nonatomic, copy) NSString *movieID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *scoretime;
@property (nonatomic, copy) NSString *cover;


@end
