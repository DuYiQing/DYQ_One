//
//  QuestionViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionCollectionViewCell.h"
#import "HttpClient.h"
#import "QuestionInfoModel.h"
#import "MJExtension.h"
#import "CommentModel.h"

static NSString *const collectionViewCell = @"collectionViewCell";

@interface QuestionViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UICollectionView *questionCV;
@property (nonatomic, retain) QuestionInfoModel *questionInfoModel;
@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, retain) NSMutableArray *commentArr;
@property (nonatomic, retain) CommentModel *commentModel;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) NSInteger index;


@end

@implementation QuestionViewController

- (void)dealloc {
    [_questionInfoModel release];
    [_questionCV release];
    [_contentArr release];
    [_commentArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    self.questionCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _questionCV.backgroundColor = [UIColor whiteColor];
    _questionCV.contentSize = CGSizeMake(SCREEN_WIDTH * 10, SCREEN_HEIGHT);
    _questionCV.pagingEnabled = YES;
    _questionCV.delegate = self;
    _questionCV.dataSource = self;
    [self.view addSubview:_questionCV];
    [_questionCV release];
    
    [_questionCV registerClass:[QuestionCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
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
    _contentID = _questionIDArr[_index];
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/question/%@", _contentID] success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        self.questionInfoModel = [QuestionInfoModel mj_objectWithKeyValues:dataDic];
        self.contentArr = [_questionInfoModel.answer_content componentsSeparatedByString:@"<br>\n"];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/question/%@/0", _contentID] success:^(id result) {
            NSDictionary *tempDic = [result objectForKey:@"data"];
            NSArray *dataArr = [tempDic objectForKey:@"data"];
            [self.commentArr removeAllObjects];
            for (NSDictionary *dataDic in dataArr) {
                self.commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
                [_commentArr addObject:_commentModel];
            }
        } failure:^(id error) {
            NSLog(@"error : %@", error);
        }];
        [_questionCV reloadData];
    } failure:^(id error) {
        NSLog(@"error : %@", error);
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QuestionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    cell.questionInfoModel = _questionInfoModel;
    cell.contentArr = _contentArr;
    cell.commentArr = _commentArr;

    return cell;
}

- (void)data {
    [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/question/%@", _contentID] success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        self.questionInfoModel = [QuestionInfoModel mj_objectWithKeyValues:dataDic];
        self.contentArr = [_questionInfoModel.answer_content componentsSeparatedByString:@"<br>\n"];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/question/%@/0", _contentID] success:^(id result) {
            NSDictionary *tempDic = [result objectForKey:@"data"];
            NSArray *dataArr = [tempDic objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArr) {
                self.commentModel = [CommentModel mj_objectWithKeyValues:dataDic];
                [_commentArr addObject:_commentModel];
                
            }
            [self getView];
        } failure:^(id error) {
            NSLog(@"error : %@", error);
        }];
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
