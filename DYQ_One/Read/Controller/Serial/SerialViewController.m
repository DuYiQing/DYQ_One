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

static NSString *const serialCollectionViewCell = @"serialCollectionViewCell";


@interface SerialViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *serialCollectionView;
@property (nonatomic, retain) NSArray *contentArr;
@property (nonatomic, retain) NSMutableArray *serialArr;
@property (nonatomic, retain) SerialModel *serialModel;

@end

@implementation SerialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.hidden = YES;
    
    self.serialArr = [NSMutableArray array];
    
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
    return cell;
    
}

- (void)data {
    
    NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/serialcontent/" mutableCopy];
    [urlString appendString:_contentID];
    
    [HttpClient GETWithURLString:urlString success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSString *content = [dataDic objectForKey:@"content"];
        self.contentArr = [content componentsSeparatedByString:@"<br>\n"];
        self.serialModel = [SerialModel mj_objectWithKeyValues:dataDic];

        [self getView];
        
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
