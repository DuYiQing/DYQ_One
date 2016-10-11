//
//  SerialViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SerialViewController.h"
#import "HttpClient.h"
#import "SerialModel.h"
#import "MJExtension.h"
#import "NovelCollectionViewCell.h"
#import "SerialCollectionViewCell.h"
#import "CommentModel.h"

static NSString *const serialCollectionViewCell = @"serialCollectionViewCell";


@interface SerialViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *serialCollectionView;
@property (nonatomic, retain) NSMutableArray *contentArr;
@property (nonatomic, retain) NSMutableArray *serialArr;
@property (nonatomic, retain) SerialModel *serialModel;
@property (nonatomic, retain) NSMutableArray *commentArr;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) NSInteger index;

@end

@implementation SerialViewController

- (void)dealloc {
    [_contentArr release];
    [_serialModel release];
    [_commentArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.hidden = YES;
    
    self.serialArr = [NSMutableArray array];
    self.commentArr = [NSMutableArray array];
    self.index = 0;
    [self data];
    
}

- (void)getView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection
    = UICollectionViewScrollDirectionHorizontal;
    
    self.serialCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _serialCollectionView.backgroundColor = [UIColor blueColor];
    _serialCollectionView.dataSource = self;
    _serialCollectionView.delegate = self;
    _serialCollectionView.pagingEnabled = YES;
    [self.view addSubview:_serialCollectionView];
    [_serialCollectionView release];
    
    [_serialCollectionView registerClass:[SerialCollectionViewCell class] forCellWithReuseIdentifier:serialCollectionViewCell];

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.contentOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ((scrollView.contentOffset.x >= _contentOffsetX) && (_index <= 8) && (_index >= 0)) {
        _index++;
    }
    if ((scrollView.contentOffset.x < _contentOffsetX) && (_index >= 1) && (_index <= 9)) {
        _index--;
    }
    _contentID = _serialIDArr[_index];
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/serialcontent/" mutableCopy];
    [urlString appendString:_contentID];
    
    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"content"];
        self.contentArr = [content componentsSeparatedByString:@"<br>"];
        for (int i = 0; i < _contentArr.count; i++) {
            if ([_contentArr[i] isEqualToString:@"\n"]) {
                NSInteger index = [_contentArr indexOfObject:_contentArr[i]];
                [_contentArr removeObjectAtIndex:index];
            }
            if ([_contentArr[i] isEqualToString:@"\r\n"]) {
                NSInteger index = [_contentArr indexOfObject:_contentArr[i]];
                [_contentArr removeObjectAtIndex:index];
            }
        }
        
        self.serialModel = [SerialModel mj_objectWithKeyValues:dataDic];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/0", _contentID] success:^(id result) {

            NSDictionary *dataDic = [result objectForKey:@"data"];
            NSArray *dataArr = [dataDic objectForKey:@"data"];
            for (NSDictionary *commentDic in dataArr) {
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
                [_commentArr addObject:commentModel];
            }
            [_serialCollectionView reloadData];
//            [self getView];
        } failure:^(id error) {
            NSLog(@"error : %@", error);
        }];
        [_serialCollectionView reloadData];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SerialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:serialCollectionViewCell forIndexPath:indexPath];
    cell.serialModel = _serialModel;
    cell.contentArr = _contentArr;
    cell.commentArr = _commentArr;
    return cell;
    
}

- (void)data {
    
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/serialcontent/" mutableCopy];
    [urlString appendString:_contentID];
    
    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"content"];
        self.contentArr = [content componentsSeparatedByString:@"<br>"];
        for (int i = 0; i < _contentArr.count; i++) {
            if ([_contentArr[i] isEqualToString:@"\n"]) {
                NSInteger index = [_contentArr indexOfObject:_contentArr[i]];
                [_contentArr removeObjectAtIndex:index];
            }
            if ([_contentArr[i] isEqualToString:@"\r\n"]) {
                NSInteger index = [_contentArr indexOfObject:_contentArr[i]];
                [_contentArr removeObjectAtIndex:index];
            }
        }

        self.serialModel = [SerialModel mj_objectWithKeyValues:dataDic];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/0", _contentID] success:^(id result) {
//            NSLog(@"%@", result);
            NSDictionary *dataDic = [result objectForKey:@"data"];
            NSArray *dataArr = [dataDic objectForKey:@"data"];
            for (NSDictionary *commentDic in dataArr) {
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
                [_commentArr addObject:commentModel];
            }
            [self getView];
        } failure:^(id error) {
            NSLog(@"error : %@", error);
        }];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
