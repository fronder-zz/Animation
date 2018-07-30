//
//  RequestManager.h
//  AccentureTask
//
//  Created by Hasan on 4/20/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN
@interface RequestManager : NSObject

#pragma mark - Singleton

+ (instancetype)sharedInstance;


#pragma mark - Request

- (NSURLSessionDataTask *)requestWeather:(nullable NSDictionary*)params success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;
- (NSURLSessionDataTask *)requestWeatherForID:(nullable NSString *)ID params:(nullable NSDictionary*)params success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
