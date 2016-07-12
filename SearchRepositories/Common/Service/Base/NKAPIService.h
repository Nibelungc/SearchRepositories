//
//  NKAPIService.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLJSONAdapter.h>
#import "NSArray+SQExtended.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NKAPIServiceRequestCompletion)(id _Nullable json, NSError * _Nullable error);

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGET
};

@interface NKAPIService : NSObject

@property (strong, nonatomic, readonly) NSURLSession *session;

@property (copy, nonatomic, readonly) NSURL *baseUrl;

- (instancetype)initWithAPIPath:(NSString *)APIPath;

- (NSURLSessionDataTask *)dataTaskWithMethod:(HTTPMethod)method
                                     request:(NSString *)requestString
                                   parametrs:(nullable NSDictionary *)parametrs
                                  completion:(NKAPIServiceRequestCompletion)completion;

- (NSString *)encodeStringForURL:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
