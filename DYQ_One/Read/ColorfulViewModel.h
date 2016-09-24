//
//  ColorfulViewModel.h
//  DYQ_One
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DYQBaseModel.h"

@interface ColorfulViewModel : DYQBaseModel

@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *author;

@end
