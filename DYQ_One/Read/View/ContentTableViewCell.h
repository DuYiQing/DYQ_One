//
//  ContentTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NovelModel;
@interface ContentTableViewCell : UITableViewCell

@property (nonatomic, retain) NovelModel *novelModel;
@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, assign) long row;


@end
