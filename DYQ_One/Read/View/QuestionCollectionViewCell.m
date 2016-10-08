//
//  QuestionCollectionViewCell.m
//  DYQ_One
//
//  Created by DYQ on 16/10/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "QuestionCollectionViewCell.h"
#import "QuestionInfoModel.h"
#import "BottonAuthorTableViewCell.h"

@interface QuestionCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *questionTableView;


@end

@implementation QuestionCollectionViewCell

- (void)dealloc {
    [_questionTableView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _questionTableView.delegate = self;
        _questionTableView.dataSource = self;
        _questionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_questionTableView];
        [_questionTableView release];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 2;
    }
    if (1 == section) {
        return _contentArr.count + 1;
    }
    if (2 == section) {
        return 8;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            return 50;
        }
        if (1 == indexPath.row) {
            NSString *info = _questionInfoModel.question_content;
            CGSize infoSize = CGSizeMake(tableView.frame.size.width - 40, 1000);
            NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15.f]};
            
            CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
            
            return ceil(infoRect.size.height);
        }
    }
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            return 40;
        }
        NSString *info = _contentArr[indexPath.row -1];
        CGSize infoSize = CGSizeMake(tableView.frame.size.width - 40, 1000);
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15.f]};
            
        CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
            
        return ceil(infoRect.size.height);
    }
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"question"];
            if (nil == cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"question"] autorelease];
            }
            cell.textLabel.text = _questionInfoModel.question_title;
            cell.textLabel.font = kFONT_SIZE_18_BOLD;
            return cell;
        }
        if (1 == indexPath.row) {
            UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"questionContent"];
            if (nil == cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"questionContent"] autorelease];
            }
            cell.textLabel.text = _questionInfoModel.question_content;
            cell.textLabel.font = [UIFont systemFontOfSize:15.f];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.numberOfLines = 0;
            [cell.textLabel sizeToFit];
            return cell;
        }
    }
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answer"];
            if (nil == cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"answer"]autorelease];
            }
            cell.textLabel.text = _questionInfoModel.answer_title;
            cell.textLabel.font = kFONT_SIZE_18_BOLD;
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"answerContent%ld", indexPath.row]];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"answerContent%ld", indexPath.row]] autorelease];
        }
        cell.textLabel.text = _contentArr[indexPath.row - 1];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        return cell;

    }
    BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (nil == cell) {
        cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]] autorelease];
    }
    CommentModel *commentModel = _commentArr[indexPath.row];
    cell.commentModel = commentModel;
    return cell;
}

@end
