//
//  ListCollectionViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListCollectionViewCellDelegate <NSObject>

- (void)getCellIndex:(NSInteger)index;

@end

@interface ListCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) NSMutableArray *essayArr;
@property (nonatomic, retain) NSMutableArray *serialArr;
@property (nonatomic, retain) NSMutableArray *questionArr;
@property (nonatomic, assign) NSInteger currentSection;
@property (nonatomic, assign) id<ListCollectionViewCellDelegate>indexDelegate;

@end
