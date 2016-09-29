//
//  MovieStoryModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"
#import "UserModel.h"
#import "MJExtension.h"

@interface MovieStoryModel : DYQBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSNumber *praisenum;
@property (nonatomic, copy) NSString *input_date;
@property (nonatomic, retain) UserModel *user;

@end
