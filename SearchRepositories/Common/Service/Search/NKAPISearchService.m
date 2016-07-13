//
//  NKAPISearchService.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKAPISearchService.h"
#import "NKRepository.h"

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
    NSString *encodedQuery = [self encodeStringForURL:queryString];
    NSString *requestString = [NSString stringWithFormat:@"%@?q=%@&page=%@", kRepositoryPath, encodedQuery, pageNumber];
    self.currentDataTask =
    [self dataTaskWithMethod:HTTPMethodGET
                     request:requestString
                   parametrs:nil
                  completion:^(id  _Nullable json, NSError * _Nullable error) {
                      NSError *parseError = nil;
                      NSArray *JSONArray = json[@"items"];
                      NSArray<NKRepository *>*results = @[];
                      if (JSONArray != nil) {
                          results = [MTLJSONAdapter modelsOfClass:[NKRepository class]
                                                    fromJSONArray:JSONArray
                                                            error:&parseError];
                          for (NKRepository *repo in results) {
                              repo.favorite = [self.localStorage containsItem:repo];
                          }
                      }
                      dispatch_async(dispatch_get_main_queue(), ^{
                          completion(results, error?:parseError);
                      });
                  }];
    [self.currentDataTask resume];
}

@end
