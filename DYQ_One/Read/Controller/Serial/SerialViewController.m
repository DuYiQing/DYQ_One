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
// 获取scrollView开始拖拽时的偏移量
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.contentOffsetX = scrollView.contentOffset.x;
}

// collectionView左右滑动时更换tableView上的数据
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 右滑
    if ((scrollView.contentOffset.x >= _contentOffsetX) && (_index <= 8) && (_index >= 0)) {
        _index++;
    }
    // 左滑
    if ((scrollView.contentOffset.x < _contentOffsetX) && (_index >= 1) && (_index <= 9)) {
        _index--;
    }
    _contentID = _serialIDArr[_index];
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/serialcontent/" mutableCopy];
    [urlString appendString:_contentID];
    
    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"content"];
        // 文本内容太多,label无法一次显示全,用<br>标识符将文本分割成段落存入数组
        NSArray *array = [NSArray array];
        array = [content componentsSeparatedByString:@"<br>"];
        self.contentArr = [NSMutableArray array];
        for (NSString *string in array) {
            string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            
            [_contentArr addObject:string];
        }
        
        self.serialModel = [SerialModel mj_objectWithKeyValues:dataDic];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/0", _contentID] success:^(id result) {

            NSDictionary *dataDic = [result objectForKey:@"data"];
            NSArray *dataArr = [dataDic objectForKey:@"data"];
            [self.commentArr removeAllObjects];
            for (NSDictionary *commentDic in dataArr) {
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
                [_commentArr addObject:commentModel];
            }
            [_serialCollectionView reloadData];

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

// 网络请求.数据解析
- (void)data {
    
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/serialcontent/" mutableCopy];
    [urlString appendString:_contentID];
    
    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"content"];

        NSArray *array = [NSArray array];
        array = [content componentsSeparatedByString:@"<br>"];
        self.contentArr = [NSMutableArray array];
        for (NSString *string in array) {
            string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            [_contentArr addObject:string];
        }

        self.serialModel = [SerialModel mj_objectWithKeyValues:dataDic];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/0", _contentID] success:^(id result) {
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
