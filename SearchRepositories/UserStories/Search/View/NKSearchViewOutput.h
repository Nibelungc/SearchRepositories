//
//  NKSearchViewOutput.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKViewOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NKSearchViewOutput <NKViewOutput>

@required

- (void)didStartSearchingByString:(NSString *)string;

- (void)didTapCellWithItem:(id)item;

- (void)loadMoreData;

@end

NS_ASSUME_NONNULL_END