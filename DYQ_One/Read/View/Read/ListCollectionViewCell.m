//
//  ListCollectionViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ListCollectionViewCell.h"
#import "ReadTableViewCell.h"
#import "EssayModel.h"
#import "SerialModel.h"
#import "QuestionModel.h"
#import "HttpClient.h"
#import "MJExtension.h"
#import "StoryViewController.h"

static NSString *const listCell = @"listCell";

@interface ListCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *listTableView;
@property (nonatomic, retain) UIView *emptyView;


@end


@implementation ListCollectionViewCell

- (void)dealloc {
    [_essayArr release];
    [_serialArr release];
    [_questionArr release];
    [_listTableView release];
    [_emptyView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.essayArr = [NSMutableArray array];
        self.serialArr = [NSMutableArray array];
        self.questionArr = [NSMutableArray array];
        
        self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        _listTableView.rowHeight = 150;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_listTableView];
        [_listTableView release];
        
        self.emptyView = [[UIView alloc] initWithFrame:CGRectZero];
        _emptyView.layer.cornerRadius = 5.f;
        _emptyView.layer.borderWidth = 1.5f;
        _emptyView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _emptyView.userInteractionEnabled = NO;
        [_listTableView addSubview:_emptyView];
        [_emptyView release];
        
        
        [_listTableView registerClass:[ReadTableViewCell class] forCellReuseIdentifier:listCell];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.indexDelegate getCellIndex:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (0 == indexPath.row) {
        EssayModel *essayModel = _essayArr[_currentSection];
//        NSLog(@"  : %ld", _currentSection);
        cell.essayModel = essayModel;
        
    }
    if (1 == indexPath.row) {
        SerialModel *serialModel = _serialArr[_currentSection];
        cell.serialModel = serialModel;
        
    }
    if (2 == indexPath.row) {
        QuestionModel *questionMode = _questionArr[_currentSection];
        cell.questionModel = questionMode;
        
    }
        
    
    return cell;

}

- (void)setEssayArr:(NSMutableArray *)essayArr {
    if (_essayArr != essayArr) {
        [_essayArr release];
        _essayArr = [essayArr retain];

    }
    [_listTableView reloadData];
}

- (void)setSerialArr:(NSMutableArray *)serialArr {
    if (_serialArr != serialArr) {
        [_serialArr release];
        _serialArr = [serialArr retain];
    }
    [_listTableView reloadData];
}

- (void)setQuestionArr:(NSMutableArray *)questionArr {
    if (_questionArr != questionArr) {
        [_questionArr release];
        _questionArr = [questionArr retain];
    }
    [_listTableView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _listTableView.frame = CGRectMake(0, -50, SCREEN_WIDTH, 430);
    
    _emptyView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, _listTableView.bounds.size.height);
}



@end
