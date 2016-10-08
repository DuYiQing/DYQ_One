//
//  QuestionInfoModel.h
//  DYQ_One
//
//  Created by DYQ on 16/10/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionInfoModel : NSObject

@property (nonatomic, copy) NSString *question_title;
@property (nonatomic, copy) NSString *question_content;
@property (nonatomic, copy) NSString *answer_title;
@property (nonatomic, copy) NSString *answer_content;
@property (nonatomic, copy) NSString *question_makettime;
@property (nonatomic, retain) NSNumber *praisenum;
@property (nonatomic, retain) NSNumber *commentnum;

@end
