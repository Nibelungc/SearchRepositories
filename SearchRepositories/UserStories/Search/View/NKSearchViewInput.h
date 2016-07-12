//
//  NKSearchViewInput.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKViewInput.h"

NS_ASSUME_NONNULL_BEGIN

@class NKRepository;

@protocol NKSearchViewInput <NKViewInput>

@required

- (void)didFailSearchWithError:(NSError *)error;

- (void)didFinishSearchWithResults:(NSArray <NKRepository *>*)results;

- (void)didLoadMoreResults:(NSArray <NKRepository *>*)results;

@end

NS_ASSUME_NONNULL_END
