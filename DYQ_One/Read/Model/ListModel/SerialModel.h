//
//  SerialModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DYQBaseModel.h"
#import "AuthorInfoModel.h"

@interface SerialModel : DYQBaseModel

@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *excerpt;
@property (nonatomic, copy) NSString *maketime;
@property (nonatomic, retain) AuthorInfoModel *author;


@end
