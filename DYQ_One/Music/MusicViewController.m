//
//  MusicViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MusicViewController.h"
#import "HttpClient.h"
#import "MusicCollectionViewCell.h"
#import "MusicModel.h"
#import "MJExtension.h"
#import "CommentModel.h"

static NSString *const musicCVCell = @"musicCVCell";

@interface MusicViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) NSArray *musicListArr;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) MusicModel *musicModel;
@property (nonatomic, retain) NSArray *storyArr;
@property (nonatomic, retain) NSString *musicID;
@property (nonatomic, retain) NSMutableArray *commentArr;
@property (nonatomic, assign) NSInteger currentItem;
@property (nonatomic, assign) CGFloat contentOffsetX;

@end

@implementation MusicViewController

- (void)dealloc {
    [_musicListArr release];
    [_collectionView release];
    [_storyArr release];
    [_musicModel release];
    [_musicID release];
    [_commentArr release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"音乐";
    self.commentArr = [NSMutableArray array];

    [self data];
}

- (void)getView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    // 设置滚动方向为水平方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 设置整页翻动
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
    [_collectionView release];
    
    
    [_collectionView registerClass:[MusicCollectionViewCell class] forCellWithReuseIdentifier:musicCVCell];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/music/detail/" mutableCopy];
    [urlString appendString:_musicListArr[_currentItem + 1]];
    [HttpClient GETWithURLString:urlString success:^(id result) {

        NSDictionary *dataDic = [result objectForKey:@"data"];
        self.musicModel = [MusicModel mj_objectWithKeyValues:dataDic];
        self.musicID = [dataDic objectForKey:@"id"];
        self.storyArr = [_musicModel.story componentsSeparatedByString:@"<br>\r\n"];
        [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/music/%@/0", _musicID] success:^(id result) {
            NSDictionary *dataDic = [result objectForKey:@"data"];
            NSArray *dataArr = [dataDic objectForKey:@"data"];
            for (NSDictionary *commentDic in dataArr) {
                CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
                [_commentArr addObject:commentModel];
            }
            [_collectionView reloadData];
        } failure:^(id error) {
            NSLog(@"error : %@", error);
        }];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _musicListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:musicCVCell forIndexPath:indexPath];
    cell.musicModel = _musicModel;
    cell.storyArr = _storyArr;
    cell.commentArr = _commentArr;
    self.currentItem = indexPath.item;

    return cell;
}

- (void)data {
    [HttpClient GETWithURLString:@"http://v3.wufazhuce.com:8000/api/music/idlist/0" success:^(id result) {
        self.musicListArr = [result objectForKey:@"data"];
        
        NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/music/detail/" mutableCopy];
        [urlString appendString:_musicListArr[0]];
        [HttpClient GETWithURLString:urlString success:^(id result) {
            NSDictionary *dataDic = [result objectForKey:@"data"];
            self.musicModel = [MusicModel mj_objectWithKeyValues:dataDic];
            self.musicID = [dataDic objectForKey:@"id"];
            self.storyArr = [_musicModel.story componentsSeparatedByString:@"<br>\r\n"];
            [HttpClient GETWithURLString:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/music/%@/0", _musicID] success:^(id result) {
                NSDictionary *dataDic = [result objectForKey:@"data"];
                NSArray *dataArr = [dataDic objectForKey:@"data"];
                for (NSDictionary *commentDic in dataArr) {
                    CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:commentDic];
                    [_commentArr addObject:commentModel];
//                    NSLog(@"%@", _commentArr);
                    [self getView];
                }
            } failure:^(id error) {
                NSLog(@"error : %@", error);
            }];
           
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
