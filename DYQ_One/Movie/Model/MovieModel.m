//
//  MovieModel.m
//  DYQ_One
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieModel.h"
#import <MJExtension.h>

@implementation MovieModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"movieID" : @"id"};
}

@end
