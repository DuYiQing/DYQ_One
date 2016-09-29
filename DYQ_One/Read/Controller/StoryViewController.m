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

static NSString *const collectionViewCell = @"collectionViewCell";


@interface StoryViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, retain) UICollectionView *novelCollectionView;
@property (nonatomic, retain) NSMutableArray *storyArr;
@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, assign) long currentSection;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.storyArr = [NSMutableArray array];
    self.contentArr = [NSArray array];
//    self.tabBarController.tabBar.hidden = YES;
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%ld", _currentSection);
//    _contentID = _storyArr[_currentSection];
    NSLog(@"id : %@", _contentID);
    
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
    cell.storyArr = _storyArr;
    cell.contentArr = _contentArr;

    return cell;
}


- (void)data {
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/essay/" mutableCopy];
    [urlString appendString:_contentID];
    [HttpClient GETWithURLString:urlString success:^(id result) {

        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"hp_content"];
        self.contentArr = [content componentsSeparatedByString:@"<br>"];
        
        NovelModel *novelModel = [NovelModel modelWithDic:dataDic];
        [_storyArr addObject:novelModel];

        [_novelCollectionView reloadData];
        [self getView];
     
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
