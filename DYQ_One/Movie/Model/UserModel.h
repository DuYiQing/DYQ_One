//
//  UserModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"
#import "MJExtension.h"

@interface UserModel : DYQBaseModel

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *web_url;

@end
