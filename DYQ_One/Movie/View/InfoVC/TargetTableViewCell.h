//
//  TargetTableViewCell.h
//  DYQ_One
//
//  Created by DYQ on 16/10/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const ActorMode;
FOUNDATION_EXTERN NSString *const TargetMode;

@interface TargetTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *actorInfoLabel;

@property (nonatomic, retain) NSArray *targetArr;

- (void)displayWithMode:(NSString *)modeName;

@end
