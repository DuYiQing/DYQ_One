//
//  MusicModel.h
//  DYQ_One
//
//  Created by DYQ on 16/9/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"
#import "AuthorInfoModel.h"

@interface MusicModel : DYQBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *story_title;
@property (nonatomic, copy) NSString *story;
@property (nonatomic, copy) NSString *music_id;
@property (nonatomic, copy) NSString *charge_edt;
@property (nonatomic, retain) NSNumber *praisenum;
@property (nonatomic, copy) NSString *maketime;
@property (nonatomic, retain) AuthorInfoModel *author;
@property (nonatomic, retain) AuthorInfoModel *story_author;
@property (nonatomic, retain) NSNumber *sharenum;
@property (nonatomic, retain) NSNumber *commentnum;

@end
