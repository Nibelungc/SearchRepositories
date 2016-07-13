//
//  NKFavoritesPresenter.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKFavoritesPresenter.h"
#import "NKFavoritesViewInput.h"
#import "NKLocalStorage.h"
#import "NKRepository.h"

@interface NKFavoritesPresenter ()

@property (weak, nonatomic) id <NKFavoritesViewInput> view;

@end

@implementation NKFavoritesPresenter

@dynamic view;

#pragma mark - NKFavoritesViewOutput

- (void)viewWillAppear {
    NSArray <NKRepository *>* items = [self.localStorage getItemsWithClass:[NKRepository class]];
    if (items.count > 0){
        [self.view showItems:items];
    } else {
        [self.view showEmptyState];
    }
}

- (void)removeItemFromFavorites:(NKRepository *)repository {
    if (repository == nil) { return; }
    [self.localStorage removeItem:repository];
}

@end
