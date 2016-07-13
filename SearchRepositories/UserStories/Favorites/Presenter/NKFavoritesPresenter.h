//
//  NKFavoritesPresenter.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKBasePresenter.h"
#import "NKFavoritesViewOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NKLocalStorage;

@interface NKFavoritesPresenter : NKBasePresenter <NKFavoritesViewOutput>

@property (strong, nonatomic) id <NKLocalStorage> localStorage;

@end

NS_ASSUME_NONNULL_END