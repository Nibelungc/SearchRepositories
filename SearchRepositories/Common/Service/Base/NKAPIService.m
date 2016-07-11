//
//  NKAPIService.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NKAPIService.h"

static NSString * const kBaseURL = @"https://api.github.com/";

@interface NKAPIService ()

@property (strong, nonatomic, readwrite) NSURLSession *session;

@property (copy, nonatomic, readwrite) NSURL *baseURL;

@property (copy, nonatomic, readwrite) NSURL *serviceURL;

@end

@implementation NKAPIService

- (instancetype)initWithAPIPath:(NSString *)APIPath {
    if (self = [super init]){
        _baseUrl = [NSURL URLWithString:kBaseURL];
        _serviceURL = [_baseUrl URLByAppendingPathComponent:APIPath];
    }
    return self;
}

- (NSURLSessionDataTask *)dataTaskWithMethod:(HTTPMethod)method
                                     request:(NSString *)requestString
                                   parametrs:(nullable NSDictionary *)parametrs
                                  completion:(NKAPIServiceRequestCompletion)completion {
    [[self class] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *URL = [self.serviceURL URLByAppendingPathComponent:requestString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = [self stringValueForHTTPMethod:method];
    request.HTTPBody = [self serializedBodyDataFromParametrs:parametrs];
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:request
                    completionHandler:
     ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         [[self class] setNetworkActivityIndicatorVisible:NO];
         completion([self jsonFromSerializedData:data], error);
     }];
    return dataTask;
}

#pragma mark - Custom accessors

- (NSURLSession *)session {
    if (!_session){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

#pragma mark - Helpers

#pragma mark -- Request building

- (NSString *)stringValueForHTTPMethod:(HTTPMethod)method {
    switch (method) {
        case HTTPMethodGET: {
            return @"GET";
        }
    }
}

- (nullable NSData *)serializedBodyDataFromParametrs:(nullable NSDictionary *) parametrs {
    if (!parametrs) { return nil; }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:parametrs
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    NSAssert(data, error.localizedDescription);
    return data;
}

- (nullable NSDictionary *)jsonFromSerializedData:(nullable NSData *)data {
    if (!data) { return nil; }
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                            error:&error];
    NSAssert(json, error.localizedDescription);
    return json;
}

#pragma mark -- Activity Indicator

+ (void)setNetworkActivityIndicatorVisible:(BOOL)setVisible {
    static NSInteger NumberOfCallsToSetVisible = 0;
    if (setVisible){
        NumberOfCallsToSetVisible++;
    } else {
        NumberOfCallsToSetVisible--;
    }
    if (NumberOfCallsToSetVisible < 0){
        NumberOfCallsToSetVisible = 0;
    }
    NSAssert(NumberOfCallsToSetVisible >= 0, @"Network Activity Indicator was asked to hide more often than shown");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(NumberOfCallsToSetVisible > 0)];
}

@end
