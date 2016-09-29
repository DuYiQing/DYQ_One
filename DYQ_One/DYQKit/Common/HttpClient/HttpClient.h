//
//  HttpClient.h
//  EAKit
//
//  Created by Eiwodetianna on 16/9/20.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject

+ (void)GETWithURLString:(NSString *)URLString success:(void(^)(id))success failure:(void(^)(id))failure;

+ (void)POSTWithURLString:(NSString *)URLString HTTPBody:(NSString *)httpBody success:(void(^)(id))success failure:(void(^)(id))failure;


@end
