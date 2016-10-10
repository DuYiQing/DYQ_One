//
//  TargetTableViewCell.m
//  DYQ_One
//
//  Created by DYQ on 16/10/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TargetTableViewCell.h"

NSString *const ActorMode = @"actorMode";
NSString *const TargetMode = @"targetMode";

@interface TargetTableViewCell ()

@property (nonatomic, retain) UIView *targetView;
@property (nonatomic, retain) NSMutableArray *labelArr;



@end

@implementation TargetTableViewCell

- (void)dealloc {
    [_targetView release];
    [_labelArr release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.labelArr = [NSMutableArray array];
        
        self.targetView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_targetView];
        [_targetView release];
//        NSLog(@"%@", _targetArr);
        
        int row = 0, colum = 0;
        for (int i = 0; i < 5; i++) {
            if (i >= 3) {
                colum = 0;
                row = 1;
            }
            if (i == 4) {
                colum++;
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(colum * (SCREEN_WIDTH / (3 - row)), row * (130 / 2), SCREEN_WIDTH / (3 - row), 130 / 2)];
            label.layer.borderColor = [UIColor lightGrayColor].CGColor;
            label.layer.borderWidth = 0.5f;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor lightGrayColor];
            [_labelArr addObject:label];
            [_targetView addSubview:label];
            [label release];
            colum++;
            

        }
    
        self.actorInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH - 40, 120)];
        _actorInfoLabel.hidden = YES;
        _actorInfoLabel.font = kFONT_SIZE_12_BOLD;
        _actorInfoLabel.numberOfLines = 0;

        [self.contentView addSubview:_actorInfoLabel];
        [_actorInfoLabel release];
        
    }
    return self;
}

- (void)setTargetArr:(NSArray *)targetArr {
    if (_targetArr != targetArr) {
        [_targetArr release];
        _targetArr = [targetArr retain];
        for (int i = 0; i < 5; i++) {
            UILabel *label = _labelArr[i];
            label.text = targetArr[i];
        }
    }
}

- (void)displayWithMode:(NSString *)modeName {
    if ([modeName isEqualToString:TargetMode]) {
        _actorInfoLabel.hidden = YES;
        _targetView.hidden = NO;
        self.contentView.layer.borderWidth = 2.f;
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    } else {
        _actorInfoLabel.hidden = NO;
        _targetView.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
