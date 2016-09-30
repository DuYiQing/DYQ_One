//
//  MusicViewController.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MusicViewController.h"
#import "HttpClient.h"

@interface MusicViewController ()

@property (nonatomic, retain) NSArray *musicListArr;

@end

@implementation MusicViewController

- (void)dealloc {
    [_musicListArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"音乐";
    

    [self data];

}

- (void)data {
    [HttpClient GETWithURLString:@"http://v3.wufazhuce.com:8000/api/music/idlist/0" success:^(id result) {
//        NSLog(@"%@", result);
        self.musicListArr = [result objectForKey:@"data"];
        NSMutableString *urlString = [@"http://v3.wufazhuce.com:8000/api/music/detail/" mutableCopy];
        [urlString appendString:_musicListArr[0]];
        [HttpClient GETWithURLString:urlString success:^(id result) {
            NSLog(@"%@", result);
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
