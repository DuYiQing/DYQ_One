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
#import "MJRefresh.h"
#import "CommentModel.h"
#import "HttpClient.h"

@interface QuestionCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *questionTableView;
@property (nonatomic, copy) NSString *commentNumber;
@property (nonatomic, retain) CommentModel *commentModel;

@end

@implementation QuestionCollectionViewCell

- (void)dealloc {
    [_questionTableView release];
    [_commentModel release];
    [_commentNumber release];
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
        _questionTableView.contentInset = UIEdgeInsetsMake(0, 0, 76, 0);
        [self.contentView addSubview:_questionTableView];
        [_questionTableView release];
        
        _questionTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
      
        
    }
    return self;
}
- (void)Loading {
    [self commentData];
    [_questionTableView reloadData];
    [_questionTableView.mj_footer endRefreshing];
}

- (void)commentData {
    CommentModel *commentModel = [_commentArr lastObject];
    self.commentNumber = commentModel.ID;
    
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/question/%@/%@", _questionInfoModel.ID, _commentNumber] success:^(id result) {
        NSDictionary *tempDic = [result objectForKey:@"data"];
        NSArray *dataArr = [tempDic objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            self.commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
            [_commentArr addObject:_commentModel];
            
        }
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];

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
        if (_commentArr.count < 8) {
            return _commentArr.count;
        }
        return 8;
    }
    if (3 == section) {
        return _commentArr.count - 8;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (2 == section) {
        return @"评论列表";
    }
    if (3 == section) {
        return @"                                       以上是热门评论";
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (2 == section) {
        return 20;
    }
    if (3 == section) {
        return 20;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            NSString *info = _questionInfoModel.question_title;
            CGSize infoSize = CGSizeMake(tableView.frame.size.width - 40, 1000);
            NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:19.f]};
            
            CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
            
            return 40 + ceil(infoRect.size.height);
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
            NSString *info = _questionInfoModel.answer_title;
            CGSize infoSize = CGSizeMake(tableView.frame.size.width - 40, 1000);
            NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:19.f]};
            
            CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
            
            return 40 + ceil(infoRect.size.height);
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
            cell.textLabel.numberOfLines = 0;
            [cell.textLabel sizeToFit];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    if (2 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"hotCell%ld", indexPath.row]];
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"hotCell%ld", indexPath.row]] autorelease];
        }
        CommentModel *commentModel = _commentArr[indexPath.row];
        cell.commentModel = commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    if (nil == cell) {
        cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]] autorelease];
    }
    CommentModel *commentModel = _commentArr[indexPath.row + 8];
    cell.commentModel = commentModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
