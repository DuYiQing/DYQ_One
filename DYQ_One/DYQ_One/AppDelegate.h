//
//  AppDelegate.h
//  DYQ_One
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    AFNetworkReachabilityManager *internetReach;
}

@property (strong, nonatomic) UIWindow *window;


@end

