//
//  AppDelegate.m
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDate+Categories.h"
#import "RootViewController.h"
#import "ReadViewController.h"
#import "MusicViewController.h"
#import "MovieViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()
<
UITabBarControllerDelegate
>

@end

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

#pragma mark - 捕获异常信息

void uncaughtExceptionHandler(NSException *exception) {
    
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    
    NSString *syserror = [NSString stringWithFormat:@"异常名称：%@\n异常原因：%@\n异常堆栈信息：%@", name, reason, stackArray];
    DDLogInfo(@"CRASH: %@", syserror);
    
    NSString *dirName = @"exception";
    NSString *fileDir = [NSString stringWithFormat:@"%@/%@/", [FileManagerUtils getDocumentsPath], dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[fileDir stringByExpandingTildeInPath]];
    [fileManager createFileAtPath:[fileDir stringByAppendingString:[NSDate getSystemTimeString]] contents:[syserror dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    // 首页
    RootViewController *rootVC = [[RootViewController alloc] init];
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    rootNavigationController.navigationBar.translucent = NO;
    UIImage *rootImage = [UIImage imageNamed:@"Unknown-2.png"];
    rootImage = [rootImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *rootSelectedImage = [UIImage imageNamed:@"Unknown-3.png"];
    rootSelectedImage = [rootSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:rootImage selectedImage:rootSelectedImage];
    
    
    // 阅读
    ReadViewController *readVC = [[ReadViewController alloc] init];
    UINavigationController *readNavigationController = [[UINavigationController alloc] initWithRootViewController:readVC];
    readNavigationController.navigationBar.translucent = NO;
    UIImage *readImage = [UIImage imageNamed:@"Unknown-4.png"];
    readImage = [readImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *readSelectedImage = [UIImage imageNamed:@"Unknown-5.png"];
    readSelectedImage = [readSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    readNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"阅读" image:readImage selectedImage:readSelectedImage];
    
    
    
    // 音乐
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    UINavigationController *musicNavigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    musicNavigationController.navigationBar.translucent = NO;
    UIImage *musicImage = [UIImage imageNamed:@"Unknown-6.png"];
    musicImage = [musicImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *musicSelectedImage = [UIImage imageNamed:@"Unknown-7.png"];
    musicSelectedImage = [musicSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    musicNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"音乐" image:musicImage selectedImage:musicSelectedImage];
    
    
    
    //电影
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    UINavigationController *movieNavigationController = [[UINavigationController alloc] initWithRootViewController:movieVC];
    movieNavigationController.navigationBar.translucent = NO;
    UIImage *movieImage = [UIImage imageNamed:@"Unknown-8.png"];
    movieImage = [movieImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *movieSelectedImage = [UIImage imageNamed:@"Unknown-9.png"];
    movieSelectedImage = [movieSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    movieNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:movieImage selectedImage:movieSelectedImage];
    
    
    
    // 标签视图控制器
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    rootTabBarController.viewControllers = @[rootNavigationController, readNavigationController, musicNavigationController, movieNavigationController];
    rootTabBarController.delegate = self;
    rootTabBarController.tabBar.tintColor = [UIColor colorWithRed:93.2 / 255.f green:182.1 / 255.f blue:223.6 / 255.f alpha:1.0];
    rootTabBarController.tabBar.barTintColor = [UIColor whiteColor];
    rootTabBarController.tabBar.translucent = NO;
    
    
////     使用NSUserDefaults 读取用户数据
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
////     判断是否第一次进入应用
//    if (![userDef boolForKey:@"notFirst"]) {
////         如果是第一次,进入引导页
//        GuideViewController *guideViewController = [[GuideViewController alloc] init];
//        self.window.rootViewController = guideViewController;
//        [guideViewController release];
    
//    } else {
//        // 否则直接进入应用
        self.window.rootViewController = rootTabBarController;
//
//    }
    [rootVC release];
    [rootNavigationController release];
    [readVC release];
    [readNavigationController release];
    [musicVC release];
    [musicNavigationController release];
    [movieVC release];
    [movieNavigationController release];
    
    [rootTabBarController release];

    [_window release];
    
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
