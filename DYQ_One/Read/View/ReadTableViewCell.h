//
//  ReadTableViewCell.h
//  DYQ_One
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EssayModel;
@class SerialModel;
@class QuestionModel;

@interface ReadTableViewCell : UITableViewCell

@property (nonatomic, retain) EssayModel *essayModel;
@property (nonatomic, retain) SerialModel *serialModel;
@property (nonatomic, retain) QuestionModel *questionModel;
@property (nonatomic, assign) CGFloat rowHeight;


@end
