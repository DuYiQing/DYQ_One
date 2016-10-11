//
//  StoryViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "StoryViewController.h"
#import "HttpClient.h"
#import "NovelModel.h"
#import "MJExtension.h"
#import "NovelCollectionViewCell.h"
#import "MJExtension.h"
#import "CommentModel.h"
#import "EssayModel.h"
#import "MJRefresh.h"


static NSString *const collectionViewCell = @"collectionViewCell";


@interface StoryViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, retain) UICollectionView *novelCollectionView;
@property (nonatomic, retain) NSMutableArray *storyArr;
@property (nonatomic, retain) NSMutableArray *contentArr;
@property (nonatomic, assign) long currentSection;
@property (nonatomic, retain) NSMutableArray *commentArr;
@property (nonatomic, retain) NovelModel *novelModel;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) CommentModel *commentModel;

@end

@implementation StoryViewController

- (void)dealloc {
    [_storyArr release];
    [_contentArr release];
    [_commentArr release];
    [_novelCollectionView release];
    [_commentModel release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.storyArr = [NSMutableArray array];
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
    
    self.novelCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _novelCollectionView.backgroundColor = [UIColor blueColor];
    _novelCollectionView.dataSource = self;
    _novelCollectionView.delegate = self;
    _novelCollectionView.pagingEnabled = YES;
    [self.view addSubview:_novelCollectionView];
    [_novelCollectionView release];
    
    [_novelCollectionView registerClass:[NovelCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
    
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
    
    _contentID = _essayIDArr[_index];
    
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/essay/" mutableCopy];
    [urlString appendString:_contentID];
    [HttpClient GETWithURLString:urlString success:^(id result) {
        
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"hp_content"];
        self.contentArr = [content componentsSeparatedByString:@"<br>"];
        for (int i = 0; i < _contentArr.count; i++) {
            if ([_contentArr[i] isEqualToString:@"\n"]) {
                NSInteger index = [_contentArr indexOfObject:_contentArr[i]];
                [_contentArr removeObjectAtIndex:index];
            }
            else if ([_contentArr[i] isEqualToString:@"\r\n"]) {
                NSInteger index = [_contentArr indexOfObject:_contentArr[i]];
                [_contentArr removeObjectAtIndex:index];
            }
        }
        
        self.novelModel = [NovelModel mj_objectWithKeyValues:dataDic];
//        [_storyArr addObject:_novelModel];
        
        [_novelCollectionView reloadData];
        
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];

    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/essay/%@/0", _contentID] success:^(id result) {
        NSDictionary *tempDic = [result objectForKey:@"data"];
        NSArray *dataArr = [tempDic objectForKey:@"data"];
        [self.commentArr removeAllObjects];
        for (NSDictionary *dataDic in dataArr) {
            self.commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
            [_commentArr addObject:_commentModel];
        }
        [_novelCollectionView reloadData];
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NovelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    self.currentSection = indexPath.section;
//    cell.storyArr = _storyArr;
    cell.novelModel = _novelModel;
    cell.contentArr = _contentArr;
    cell.commentArr = _commentArr;
    return cell;
}


- (void)data {
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/essay/" mutableCopy];
    [urlString appendString:_contentID];
    [HttpClient GETWithURLString:urlString success:^(id result) {

        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"hp_content"];
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

        self.novelModel = [NovelModel mj_objectWithKeyValues:dataDic];
//        [_storyArr addObject:_novelModel];

        [_novelCollectionView reloadData];
        [self getView];
     
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];
    
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/essay/%@/0", _contentID] success:^(id result) {
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
