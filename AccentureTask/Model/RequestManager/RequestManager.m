//
//  RequestManager.m
//  AccentureTask
//
//  Created by Hasan on 4/20/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

#import "RequestManager.h"
#import "AFHTTPSessionManager.h"

NSString *const kBaseResourceURLString = @"http://api.openweathermap.org";

NSString *const kAPIKey = @"b4bdc9a2f1bcdd7abb1f185d4bf2f8e2";
NSString *const endpoint = @"/data/2.5/forecast?id=%@&APPID=%@";

@interface RequestManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation RequestManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static id shared = nil;
  dispatch_once(&onceToken, ^{
    shared = [[super alloc] initUniqueInstance];
  });
  
  return shared;
}


#pragma mark - Initializer

- (instancetype)initUniqueInstance {
  self = [super init];
  if (self) {
    self.manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:kBaseResourceURLString]];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *secPol = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    secPol.allowInvalidCertificates = YES;
    secPol.validatesDomainName = NO;
    self.manager.securityPolicy = secPol;
  }
  return self;
}


#pragma mark - Request

- (NSURLSessionDataTask *)requestWeather:(nullable NSDictionary*)params success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
  return [self requestWeatherForID:nil params:params success:success failure:failure];
}

- (NSURLSessionDataTask *)requestWeatherForID:(nullable NSString *)ID params:(nullable NSDictionary*)params success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
  NSString *finalUrlString;
  if (ID == nil) {
    finalUrlString = [NSString stringWithFormat:endpoint, @"524901", kAPIKey];
  } else {
    finalUrlString = [NSString stringWithFormat:endpoint, ID, kAPIKey];
  }
  return [self getTemplateUrl:finalUrlString paramsDict:params success:success failure:failure];
}


#pragma mark - Template

- (NSURLSessionDataTask *)getTemplateUrl:(NSString *)urlString paramsDict:(NSDictionary *)params success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *error))failure {
 
  NSURLSessionDataTask *task = [self.manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", jsonDict);
    success(jsonDict);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@", error);
    failure(error);
  }];
  
  return task;
}

@end
