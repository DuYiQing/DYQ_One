//
//  MovieInfoModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"

@interface MovieInfoModel : DYQBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailcover;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *officialstory;
@property (nonatomic, retain) NSArray *photo;


@end
