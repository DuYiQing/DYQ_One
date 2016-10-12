//
//  ReadViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReadViewController.h"
#import "HttpClient.h"
#import "ScrollViewModel.h"
#import "UIImageView+XLWebCache.h"
#import "CarouselView.h"
#import "UIImageView+XLWebCache.h"
#import "ColorfulViewController.h"
#import "EssayModel.h"
#import "MJExtension.h"
#import "SerialModel.h"
#import "QuestionModel.h"
#import "ReadTableViewCell.h"
#import "ListCollectionViewCell.h"
#import "StoryViewController.h"
#import "SerialViewController.h"
#import "QuestionViewController.h"


static NSString *const collectionViewCell = @"collectionViewCell";

@interface ReadViewController ()

<
UIScrollViewDelegate,
CarouselViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
ListCollectionViewCellDelegate
>

@property (nonatomic, retain) NSMutableArray *scrollViewArr;
@property (nonatomic, retain) NSMutableArray *imageURLArr;
@property (nonatomic, retain) UIScrollView *headScrollView;
@property (nonatomic, retain) NSMutableArray *essayArr;
@property (nonatomic, retain) NSMutableArray *serialArr;
@property (nonatomic, retain) NSMutableArray *questionArr;
@property (nonatomic, retain) CarouselView *carouselView;
@property (nonatomic, assign) long currentIndex;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, retain) UITableView *listTableView;

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *serialIDArr;
@property (nonatomic, retain) NSMutableArray *essayIDArr;
@property (nonatomic, retain) NSMutableArray *questionIDArr;


@end

@implementation ReadViewController

- (void)dealloc {
    [_scrollViewArr release];
    [_imageURLArr release];
    [_essayArr release];
    [_serialArr release];
    [_questionArr release];
    [_serialIDArr release];
    [_essayIDArr release];
    [_questionIDArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"阅读";
    self.scrollViewArr = [NSMutableArray array];
    self.imageURLArr = [NSMutableArray array];
    self.essayArr = [NSMutableArray array];
    self.serialArr = [NSMutableArray array];
    self.questionArr = [NSMutableArray array];
    self.serialIDArr = [NSMutableArray array];
    self.essayIDArr = [NSMutableArray array];
    self.questionIDArr = [NSMutableArray array];
    [self data];
    
    
}

- (void)getCarouseView {
    
    for (int i = 0; i < _scrollViewArr.count; i++) {
        ScrollViewModel *scrollViewModel = _scrollViewArr[i];
        _imageURLArr[i] = scrollViewModel.cover;
    }
    
    self.carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
    _carouselView.imageURLArr = _imageURLArr;
    _carouselView.delegate = self;
    [self.view addSubview:_carouselView];
    [_carouselView release];
    
}

- (void)getListView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 500);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection
    = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 4, SCREEN_WIDTH, 600) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentSize = CGSizeMake(SCREEN_WIDTH * 10, _collectionView.bounds.size.height);
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView release];
    
    [_collectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _essayArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    listCell.indexDelegate = self;
    listCell.currentSection = indexPath.section;
    _currentIndex = indexPath.section;
    listCell.essayArr = _essayArr;
    listCell.serialArr = _serialArr;
    listCell.questionArr = _questionArr;
    return listCell;
}

- (void)getCellIndex:(NSInteger)index {
    if (0 == index) {
        
        EssayModel *essayModel = _essayArr[_currentIndex];
//        NSLog(@"%ld", _currentIndex);
        StoryViewController *storyVC = [[StoryViewController alloc] init];
        storyVC.contentID = essayModel.content_id;
//        storyVC.essayArr = _essayArr;
        storyVC.essayIDArr = _essayIDArr;
        [self.navigationController pushViewController:storyVC animated:YES];
        [storyVC release];
    } else if (1 == index) {
        SerialModel *serialModel = _serialArr[_currentIndex];
        
        SerialViewController *serialVC = [[SerialViewController alloc] init];
        serialVC.contentID = serialModel.contentID;
        serialVC.serialIDArr = _serialIDArr;
        [self.navigationController pushViewController:serialVC animated:YES];
        [serialVC release];
    } else {
        QuestionModel *questionModel = _questionArr[_currentIndex];
        QuestionViewController *questionVC = [[QuestionViewController alloc] init];
        questionVC.contentID = questionModel.question_id;
        questionVC.questionIDArr = _questionIDArr;
        [self.navigationController pushViewController:questionVC animated:YES];
        [questionVC release];
    }
}

- (void)data {
    [HttpClient GETWithURLString:@"http://v3.wufazhuce.com:8000/api/reading/carousel" success:^(id result) {

        NSArray *dataArr = [result objectForKey:@"data"];
        for (NSDictionary *dataDic in dataArr) {
            ScrollViewModel *scrollViewModel = [ScrollViewModel modelWithDic:dataDic];
            [_scrollViewArr addObject:scrollViewModel];
        }

        [self getCarouseView];
    } failure:^(id error) {
        NSLog(@"%@", error);
    }];
    [HttpClient GETWithURLString:@"http://v3.wufazhuce.com:8000/api/reading/index" success:^(id result) {

        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSArray *essayArr = [dataDic objectForKey:@"essay"];
        NSArray *serialArr = [dataDic objectForKey:@"serial"];
        NSArray *questionArr = [dataDic objectForKey:@"question"];
        for (NSDictionary *essayDic in essayArr) {
            EssayModel *essayModel = [EssayModel mj_objectWithKeyValues:essayDic];
            [_essayArr addObject:essayModel];
            [_essayIDArr addObject:essayModel.content_id];
        }

        for (NSDictionary *serialDic in serialArr) {
            SerialModel *serialModel = [SerialModel mj_objectWithKeyValues:serialDic];
            [_serialArr addObject:serialModel];
            [_serialIDArr addObject:serialModel.contentID];
        }
        for (NSDictionary *questionDic in questionArr) {
            QuestionModel *questionModel = [QuestionModel mj_objectWithKeyValues:questionDic];
            [_questionArr addObject:questionModel];
            [_questionIDArr addObject:questionModel.question_id];
        }

        [_collectionView reloadData];
        
        [self getListView];
        
       
    } failure:^(id error) {
        [self viewWithoutNetRequest];
    }];
    
}


- (void)getImageNum:(NSInteger)imageNum {
    ColorfulViewController *colorfulVC = [[ColorfulViewController alloc] init];
    ScrollViewModel *scrollViewModel = _scrollViewArr[imageNum - 1];
    colorfulVC.imageId = scrollViewModel.id;
    colorfulVC.top_text = scrollViewModel.title;
    colorfulVC.bottom_text = scrollViewModel.bottom_text;
    colorfulVC.imageURLString = scrollViewModel.cover;
    colorfulVC.backgroundColor = scrollViewModel.bgcolor;
    [self presentViewController:colorfulVC animated:YES completion:nil];
    [colorfulVC release];
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
