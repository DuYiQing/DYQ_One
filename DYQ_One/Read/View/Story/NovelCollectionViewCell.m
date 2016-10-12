//
//  NovelCollectionViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NovelCollectionViewCell.h"
#import "TopAuthorTableViewCell.h"
#import "ContentTableViewCell.h"
#import "BottonAuthorTableViewCell.h"
#import "NovelModel.h"
#import "ColorfulTableViewCell.h"
#import "MJRefresh.h"
#import "HttpClient.h"
#import "MJExtension.h"
#import "CommentModel.h"


static NSString *const novelCVCell = @"novelCVCell";
static NSString *const contentCell = @"contentCell";
static NSString *const commentCell = @"commentCell";
static NSString *const bottomAuthorCell = @"bottomCell";
static NSString *const recommendCell = @"recommend";

@interface NovelCollectionViewCell ()

<
UITableViewDataSource,
UITableViewDelegate

>

@property (nonatomic, retain) UITableView *novelTableView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) long currentRow;
@property (nonatomic, copy) NSString *commentNumber;

@end

@implementation NovelCollectionViewCell

- (void)dealloc {
    [_novelTableView release];
    [_commentArr release];
    [_commentNumber release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.novelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _novelTableView.dataSource = self;
        _novelTableView.delegate = self;
        _novelTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [self.contentView addSubview:_novelTableView];
        [_novelTableView release];
        
        _novelTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(Loading)];
        
        [_novelTableView reloadData];
    }
    return self;
}

- (void)Loading {
    
    [self commentData];
    [_novelTableView reloadData];
    [_novelTableView.mj_footer endRefreshing];
}

- (void)commentData {
    
    CommentModel *commentModel = [_commentArr lastObject];
    self.commentNumber = commentModel.ID;
//    NSLog(@"commentNumber : %@", _commentNumber);
    
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/essay/%@/%@", _novelModel.content_id, _commentNumber] success:^(id result) {
        NSDictionary *tempDic = [result objectForKey:@"data"];
        NSArray *dataArr = [tempDic objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
            [_commentArr addObject:commentModel];
        }
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
}

- (void)setContentArr:(NSArray *)contentArr {
    if (_contentArr != contentArr) {
        [_contentArr release];
        _contentArr = [contentArr retain];
    }
    [_novelTableView reloadData];
}

//- (void)setStoryArr:(NSArray *)storyArr {
//    if (_storyArr != storyArr) {
//        [_storyArr release];
//        _storyArr = [storyArr retain];
//    }
//    [_novelTableView reloadData];
//}

- (void)setNovelModel:(NovelModel *)novelModel {
    if (_novelModel != novelModel) {
        [_novelModel release];
        _novelModel = [novelModel retain];
    }
    [_novelTableView reloadData];
}

- (void)setCommentArr:(NSMutableArray *)commentArr {
    if (_commentArr != commentArr) {
        [_commentArr release];
        _commentArr = [commentArr retain];
    }
    [_novelTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (2 == section) {
        return _contentArr.count;
    }
    if (4 == section) {
        if (_commentArr.count < 8) {
            return _commentArr.count;
        }
        return 8;
    }
    if (5 == section) {
        return _commentArr.count - 8;
    }
    return 1;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        TopAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:novelCVCell];
        if (nil == cell) {
            cell = [[[TopAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:novelCVCell] autorelease];
        }

        cell.novelModel = _novelModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (1 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commomcell"];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commomcell"] autorelease];
        }
//        NovelModel *novelModel = _storyArr[0];
        cell.textLabel.text = _novelModel.hp_title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
            
    }
    if (2 == indexPath.section) {
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld", contentCell, indexPath.row]];
        self.currentRow = indexPath.row;
        if (nil == cell) {
            cell = [[[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%ld", contentCell, indexPath.row]] autorelease];
            cell.row = _currentRow;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentArr = _contentArr;
        return cell;
        
    }
    if (3 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomAuthorCell];
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomAuthorCell] autorelease];
        }
//        NovelModel *novelModel = _storyArr[0];
        cell.novelModel = _novelModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    if (4 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld", recommendCell, indexPath.row]];
        
        cell.currentRow = indexPath.row;
        if (nil == cell) {
            cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%ld", recommendCell, indexPath.row]] autorelease];
        }
        CommentModel *commentModel = _commentArr[indexPath.row];
        cell.commentModel = commentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld", commentCell, indexPath.row]];

    cell.currentRow = indexPath.row;
    if (nil == cell) {
        cell = [[[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%ld", commentCell, indexPath.row]] autorelease];
    }
    CommentModel *commentModel = _commentArr[indexPath.row + 8];
    cell.commentModel = commentModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


@end
