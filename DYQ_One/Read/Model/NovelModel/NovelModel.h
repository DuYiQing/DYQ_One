//
//  NovelModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DYQBaseModel.h"
#import "AuthorInfoModel.h"

@interface NovelModel : DYQBaseModel

@property (nonatomic, copy) NSString *content_id;
@property (nonatomic, copy) NSString *hp_title;
@property (nonatomic, copy) NSString *hp_author;
@property (nonatomic, copy) NSString *auth_it;
@property (nonatomic, copy) NSString *hp_content;
@property (nonatomic, copy) NSString *hp_makettime;
@property (nonatomic, copy) NSString *audio;
@property (nonatomic, copy) NSArray *author;

@end
