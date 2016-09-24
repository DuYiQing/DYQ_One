//
//  NovelCollectionViewCell.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NovelCollectionViewCell.h"

@interface NovelCollectionViewCell ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *novelTableView;
//@property (nonatomic, retain)


@end

@implementation NovelCollectionViewCell

- (void)dealloc {
    [_novelTableView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.novelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _novelTableView.dataSource = self;
        _novelTableView.delegate = self;
        [self.contentView addSubview:_novelTableView];
        [_novelTableView release];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 3;
    } else if (1 == section) {
        return 8;
    }
    return 2;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

@end
