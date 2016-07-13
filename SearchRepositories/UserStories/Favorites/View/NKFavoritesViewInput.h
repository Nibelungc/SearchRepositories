//
//  NKFavoritesViewInput.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKViewInput.h"

@class NKRepository;

NS_ASSUME_NONNULL_BEGIN

@protocol NKFavoritesViewInput <NKViewInput>

@required

- (void)showItems:(NSArray <NKRepository *>*)items;

- (void)showEmptyState;

@end

NS_ASSUME_NONNULL_END