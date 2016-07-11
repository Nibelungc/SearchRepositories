//
//  NKSearchPresenter.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKBasePresenter.h"
#import "NKSearchViewOutput.h"

@protocol NKSearchService;

NS_ASSUME_NONNULL_BEGIN

@interface NKSearchPresenter : NKBasePresenter <NKSearchViewOutput>

@property (strong, nonatomic) id <NKSearchService> searchService;

@end

NS_ASSUME_NONNULL_END
