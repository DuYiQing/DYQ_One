//
//  SerialCollectionViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SerialCollectionViewCell.h"
#import "TopAuthorTableViewCell.h"
#import "SerialModel.h"
#import "ContentTableViewCell.h"
#import "BottonAuthorTableViewCell.h"
#import "InfoBaseTableViewCell.h"
#import "MJRefresh.h"
#import "CommentModel.h"
#import "HttpClient.h"

static NSString *const titleCell = @"titleCell";
static NSString *const bottomAuthorCell = @"bottomCell";
static NSString *const topAuthorCell = @"top";
static NSString *const commentCell = @"commentCell";

@interface SerialCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *serialTableView;
@property (nonatomic, assign) long currentRow;
@property (nonatomic, copy) NSString *commentNumber;

@end

@implementation SerialCollectionViewCell

- (void)dealloc {
    [_serialTableView release];
    [_commentNumber release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.serialTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _serialTableView.delegate = self;
        _serialTableView.dataSource = self;
        _serialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _serialTableView.contentInset = UIEdgeInsetsMake(0, 0, 76, 0);
        [self.contentView addSubview:_serialTableView];
        [_serialTableView release];
        
        _serialTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
       
    }
    return self;
}

- (void)Loading {
    [self commentData];
    [_serialTableView reloadData];
    [_serialTableView.mj_footer endRefreshing];
}

- (void)commentData {
    CommentModel *commentModel = [_commentArr lastObject];
    self.commentNumber = commentModel.ID;
    
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/%@", _serialModel.contentID, _commentNumber] success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSArray *dataArr = [dataDic objectForKey:@"data"];
        for (NSDictionary *commentDic in dataArr) {
            CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
            [_commentArr addObject:commentModel];
        }
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (2 == indexPath.section) {
        NSString *info = _contentArr[indexPath.row];
        CGSize infoSize = CGSizeMake(tableView.frame.size.width - 40, 1000);
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
        
        CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        return ceil(infoRect.size.height);
    }
    if (1 == indexPath.section) {
        return 50;
    }
    return 130;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (4 == section) {
        return @"评论列表";
    }
    if (5 == section) {
        return @"                                       以上是热门评论";
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (4 == section) {
        return 20;
    }
    if (5 == section) {
        return 20;
    }
    return 0.1f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (2 == section) {
        return _contentArr.count;
    } else if (4 == section) {
        if (_commentArr.count < 8) {
            return _commentArr.count;
        }
        return 8;
    } else if (5 == section) {
        return _commentArr.count - 8;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        TopAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topAuthorCell];
        if (nil == cell) {
            cell = [[[TopAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topAuthorCell] autorelease];
        }
        cell.serialModel = _serialModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    if (1 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCell] autorelease];
        }
        cell.textLabel.text = _serialModel.title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (2 == indexPath.section) {
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", (long)indexPath.row]];
        self.currentRow = indexPath.row;
        if (nil == cell) {
            cell = [[[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", (long)indexPath.row]] autorelease];
            cell.row = _currentRow;
        }
        cell.contentArr = _contentArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (3 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomAuthorCell];
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomAuthorCell] autorelease];
        }
        cell.serialModel = _serialModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (4 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"hotComment%ld", (long)indexPath.row]];
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"hotComment%ld", (long)indexPath.row]] autorelease];
        }
        CommentModel *commentModel = _commentArr[indexPath.row];
        cell.commentModel = commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld", commentCell, (long)indexPath.row]];
    if (nil == cell) {
        cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%ld", commentCell, (long)indexPath.row]] autorelease];
    }
    CommentModel *commentModel = _commentArr[indexPath.row + 8];
    cell.commentModel = commentModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
  
    
}

- (void)setCommentArr:(NSMutableArray *)commentArr {
    if (_commentArr != commentArr) {
        [_commentArr release];
        _commentArr = [commentArr retain];
        
    }
    [_serialTableView reloadData];
}


@end
