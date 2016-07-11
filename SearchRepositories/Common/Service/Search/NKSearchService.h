//
//  NKSearchService
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NKSearchCompletion)(NSArray <id>* _Nullable results, NSError* _Nullable error);

@protocol NKSearchService <NSObject>

@required

- (void)searchRepositoriesWithQueryString:(NSString *)queryString
                               pageNumber:(NSNumber *)pageNumber
                               completion:(NKSearchCompletion)completion;

@end

NS_ASSUME_NONNULL_END
