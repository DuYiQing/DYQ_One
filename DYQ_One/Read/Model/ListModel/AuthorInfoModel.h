//
//  AuthorInfoModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DYQBaseModel.h"

@interface AuthorInfoModel : DYQBaseModel

@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *wb_name;
@property (nonatomic, copy) NSString *web_url;

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
