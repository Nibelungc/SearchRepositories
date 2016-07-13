//
//  NKFavoritesViewOutput.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKViewOutput.h"

@class NKRepository;

NS_ASSUME_NONNULL_BEGIN

@protocol NKFavoritesViewOutput <NKViewOutput>

@required

- (void)removeItemFromFavorites:(NKRepository *)repository;

@end

NS_ASSUME_NONNULL_END
