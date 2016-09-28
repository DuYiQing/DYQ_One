//
//  ScrollViewModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYQBaseModel.h"

@interface ScrollViewModel : DYQBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *bottom_text;
@property (nonatomic, copy) NSString *bgcolor;

@end
