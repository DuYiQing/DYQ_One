//
//  CommentModel.h
//  DYQ_One
//
//  Created by DYQ on 16/9/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"
#import "UserModel.h"

@interface CommentModel : DYQBaseModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSNumber *praisenum;
@property (nonatomic, copy) NSString *input_date;
@property (nonatomic, retain) UserModel *user;
@property (nonatomic, copy) NSString *quote;

@end
