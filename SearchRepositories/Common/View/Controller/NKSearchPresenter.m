//
//  NKSearchPresenter.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKSearchPresenter.h"
#import "NKSearchViewInput.h"
#import "NKSearchService.h"
#import "NKLocalStorage.h"
#import "NKRepository.h"

@interface NKSearchPresenter ()

@property (weak, nonatomic) id <NKSearchViewInput> view;

@property (copy, nonatomic) NSString *currentQueryString;

@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation NKSearchPresenter

@dynamic view;

- (void)dealloc {
    [self removeNotificationObserver];
}

#pragma mark - NKSearchViewOutput

- (void)viewDidLoad {
    [self addNotificationsObserver];
}

- (void)didStartSearchingByString:(NSString *)string {
    @weakify(self)
    self.currentPage = 1;
    [self.searchService searchRepositoriesWithQueryString:string
                                               pageNumber:@(self.currentPage)
                                               completion:
     ^(NSArray<id> * _Nullable results, NSError * _Nullable error) {
         @strongify(self)
         if (!error){
             self.currentQueryString = string;
             [self.view didFinishSearchWithResults:results];
         } else {
             if (error.code != NSURLErrorCancelled){
                 [self.view didFailSearchWithError:error];
             }
         }
     }];
}

- (void)loadMoreData {
    @weakify(self)
    self.currentPage += 1;
    [self.searchService searchRepositoriesWithQueryString:self.currentQueryString
                                               pageNumber:@(self.currentPage)
                                               completion:
     ^(NSArray<id> * _Nullable results, NSError * _Nullable error) {
         @strongify(self)
         if (!error){
             [self.view didLoadMoreResults:results];
         } else {
             if (error.code != NSURLErrorCancelled){
                 [self.view didFailSearchWithError:error];
             }
         }
     }];
}

- (void)didTapCellWithItem:(id)item {
    if ([self.localStorage containsItem:item]){
        [self.localStorage removeItem:item];
    } else {
        [self.localStorage addItem:item];
    }
}

#pragma mark - Notifications

- (void)addNotificationsObserver {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(itemRemovedFromStorage:)
               name:NKLocalStorageItemDidRemoveNotification
             object:nil];
    [nc addObserver:self
           selector:@selector(itemAddedToStorage:)
               name:NKLocalStorageItemDidAddNotification
             object:nil];
}

- (void)removeNotificationObserver {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)itemRemovedFromStorage:(NSNotification *)notification {
    id item = notification.userInfo[NKLocalStorageItemKey];
    if ([item isKindOfClass:[NKRepository class]]){
        NKRepository *repo = (NKRepository *)item;
        repo.favorite = NO;
        [self.view didRemoveItemFromFavorites:item];
    }
}

- (void)itemAddedToStorage:(NSNotification *)notification {
    id item = notification.userInfo[NKLocalStorageItemKey];
    if ([item isKindOfClass:[NKRepository class]]){
        NKRepository *repo = (NKRepository *)item;
        repo.favorite = YES;
        [self.view didAddItemToFavorites:item];
    }
}


@end
