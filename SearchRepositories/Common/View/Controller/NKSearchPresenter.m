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

@interface NKSearchPresenter ()

@property (weak, nonatomic) id <NKSearchViewInput> view;

@end

@implementation NKSearchPresenter

@dynamic view;

#pragma mark - NKSearchViewInput

- (void)viewDidLoad {

}

- (void)didStartSearchingByString:(NSString *)string {
    //TODO: Implement start searching
    @weakify(self)
    [self.searchService searchRepositoriesWithQueryString:string
                                               pageNumber:@1
                                               completion:
     ^(NSArray<id> * _Nullable results, NSError * _Nullable error) {
         @strongify(self)
         if (!error){
             [self.view didFinishSearchWithResults:results];
         } else {
             [self.view didFailSearchWithError:error];
         }
     }];
}

- (void)didTapCellWithItem:(id)item {
    //TODO: Implement add/remove to favorites logic.
}

- (void)loadMoreData {
    //TODO: Implement pagination
}

@end
