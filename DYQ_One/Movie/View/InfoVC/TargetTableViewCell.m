//
//  TargetTableViewCell.m
//  DYQ_One
//
//  Created by DYQ on 16/10/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TargetTableViewCell.h"
#import "UIImageView+XLWebCache.h"

NSString *const ActorMode = @"actorMode";
NSString *const TargetMode = @"targetMode";
NSString *const PictureMode = @"pictureMode";

@interface TargetTableViewCell ()

@property (nonatomic, retain) UIView *targetView;
@property (nonatomic, retain) NSMutableArray *labelArr;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *imageViewArr;



@end

@implementation TargetTableViewCell

- (void)dealloc {
    [_targetView release];
    [_labelArr release];
    [_scrollView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.labelArr = [NSMutableArray array];
        self.imageViewArr = [NSMutableArray array];
        self.targetView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_targetView];
        [_targetView release];
        
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
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];
        [_scrollView release];
        
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
- (void)setPictureArr:(NSArray *)pictureArr {
    if (_pictureArr != pictureArr) {
        [_pictureArr release];
        _pictureArr = [pictureArr retain];
        for (int i = 0; i < pictureArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (SCREEN_WIDTH / 3), 0, SCREEN_WIDTH / 3 - 3, 130)];
            [imageView xl_setImageWithURL:[NSURL URLWithString:pictureArr[i]] placeholderImage:nil];
                imageView.backgroundColor = [UIColor lightGrayColor];
                [_scrollView addSubview:imageView];
                [_imageViewArr addObject:imageView];
                [imageView release];

        }
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH / 3 * pictureArr.count - 3, _scrollView.bounds.size.height);
    }
}

- (void)displayWithMode:(NSString *)modeName {
    if ([modeName isEqualToString:TargetMode]) {
        _actorInfoLabel.hidden = YES;
        _targetView.hidden = NO;
        _scrollView.hidden = YES;
        self.contentView.layer.borderWidth = 2.f;
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    } else if ([modeName isEqualToString:ActorMode]) {
        _actorInfoLabel.hidden = NO;
        _targetView.hidden = YES;
        _scrollView.hidden = YES;
    } else if ([modeName isEqualToString:PictureMode]) {
        _scrollView.hidden = NO;
        _actorInfoLabel.hidden = YES;
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
