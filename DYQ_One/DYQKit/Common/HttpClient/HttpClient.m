//
//  HttpClient.m
//  EAKit
//
//  Created by Eiwodetianna on 16/9/20.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient

+ (void)GETWithURLString:(NSString *)URLString success:(void(^)(id))success failure:(void(^)(id))failure {
    NSURL *url = [NSURL URLWithString:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60.f;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                success(result);
                
            } else {
                failure(error);
            }
        });
    }];
    [dataTask resume];
}


+ (void)POSTWithURLString:(NSString *)URLString HTTPBody:(NSString *)httpBody success:(void(^)(id))success failure:(void(^)(id))failure {
    
    NSURL *url = [NSURL URLWithString:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 60.f;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                success(result);
                
            } else {
                failure(error);
            }
        });
    }];
    [dataTask resume];

}


@end
