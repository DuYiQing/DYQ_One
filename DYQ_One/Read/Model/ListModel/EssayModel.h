//
//  EssayModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DYQBaseModel.h"

@interface EssayModel : DYQBaseModel

@property (nonatomic, copy) NSString *content_id;
@property (nonatomic, copy) NSString *hp_title;
@property (nonatomic, copy) NSString *hp_makettime;
@property (nonatomic, copy) NSString *guide_word;
@property (nonatomic, retain) NSMutableArray *author;



@end
