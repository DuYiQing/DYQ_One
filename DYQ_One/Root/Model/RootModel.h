//
//  RootModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"

@interface RootModel : DYQBaseModel

@property (nonatomic, copy) NSString *hpcontent_id;
@property (nonatomic, copy) NSString *hp_title;
@property (nonatomic, copy) NSString *hp_img_url;
@property (nonatomic, copy) NSString *hp_author;
@property (nonatomic, copy) NSString *hp_content;
@property (nonatomic, copy) NSString *hp_makettime;
@property (nonatomic, copy) NSNumber *praisenum;

@end
