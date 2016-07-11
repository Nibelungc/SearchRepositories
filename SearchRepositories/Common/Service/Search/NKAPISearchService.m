//
//  NKAPISearchService.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKAPISearchService.h"

static NSString * const kSearchServicePath = @"search";
static NSString * const kRepositoryPath = @"repositories";

@interface NKAPISearchService ()

@property (strong, nonatomic) NSURLSessionDataTask *currentDataTask;

@end

@implementation NKAPISearchService

#pragma mark - Initialization

- (instancetype)init {
    return [super initWithAPIPath:kSearchServicePath];
}

#pragma mark - Search

- (void)searchRepositoriesWithQueryString:(NSString *)queryString
                               pageNumber:(NSNumber *)pageNumber
                               completion:(NKSearchCompletion)completion {
    [self.currentDataTask cancel];
    NSString* requestString = [NSString stringWithFormat:@"%@?q=%@", kRepositoryPath, queryString];
    self.currentDataTask = [self dataTaskWithMethod:HTTPMethodGET
                                            request:requestString
                                          parametrs:nil
                                         completion:^(id  _Nullable json, NSError * _Nullable error) {
                                             //TODO: Parse the json and invoke the completion
                                         }];
    [self.currentDataTask resume];
    
}

@end
