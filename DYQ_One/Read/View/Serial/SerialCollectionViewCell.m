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

static NSString *const titleCell = @"titleCell";
static NSString *const bottomAuthorCell = @"bottomCell";
static NSString *const commentCell = @"commentCell";

@interface SerialCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *serialTableView;
@property (nonatomic, assign) long currentRow;

@end

@implementation SerialCollectionViewCell

- (void)dealloc {
    [_serialTableView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.serialTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _serialTableView.delegate = self;
        _serialTableView.dataSource = self;
        [self.contentView addSubview:_serialTableView];
        [_serialTableView release];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (2 == indexPath.section) {
        NSString *info = _contentArr[indexPath.row];
        CGSize infoSize = CGSizeMake(tableView.frame.size.width - 40, 1000);
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:17.f]};
        
        CGRect infoRect = [info boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        return ceil(infoRect.size.height);
    }
    if (1 == indexPath.section) {
        return 50;
    }
    return 120;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (2 == section) {
        return _contentArr.count;
    } else if (4 == section) {
        return 8;
    } else if (5 == section) {
        return 10;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (1 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCell];
        }
        cell.textLabel.text = _serialModel.title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (2 == indexPath.section) {
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        self.currentRow = indexPath.row;
        if (nil == cell) {
            cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
            cell.row = _currentRow;
        }
        cell.contentArr = _contentArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (3 == indexPath.section) {
        BottonAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomAuthorCell];
        if (nil == cell) {
            cell = [[BottonAuthorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomAuthorCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    InfoBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell];
    if (nil == cell) {
        cell = [[InfoBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
    
    
    
    
    
}

















@end
