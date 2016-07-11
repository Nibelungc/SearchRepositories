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

- (void)didFailSearchWithError:(NSError *)error;

- (void)didFinishSearchWithResults:(NSArray <id>*)results;

@end

NS_ASSUME_NONNULL_END