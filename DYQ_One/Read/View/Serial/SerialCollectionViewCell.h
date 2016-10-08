//
//  SerialCollectionViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SerialModel;

@interface SerialCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, retain) SerialModel *serialModel;
@property (nonatomic, retain) NSArray *commentArr;

@end
