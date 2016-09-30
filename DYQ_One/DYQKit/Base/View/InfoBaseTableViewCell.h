//
//  InfoBaseTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SerialModel;

@interface InfoBaseTableViewCell : UITableViewCell

@property (nonatomic, retain) SerialModel *serialModel;
@property (nonatomic, retain) NSArray *commentArr;
@property (nonatomic, assign) long currentRow;

@end
