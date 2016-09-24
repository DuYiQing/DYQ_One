//
//  QuestionModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DYQBaseModel.h"

@interface QuestionModel : DYQBaseModel

@property (nonatomic, copy) NSString *question_id;
@property (nonatomic, copy) NSString *question_title;
@property (nonatomic, copy) NSString *answer_title;
@property (nonatomic, copy) NSString *answer_content;

@end
