//
//  NKSearchPresenter.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKSearchPresenter.h"
#import "NKSearchViewInput.h"

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
}

- (void)didTapCellWithItem:(id)item {
    //TODO: Implement add/remove to favorites logic.
}

- (void)loadMoreData {
    //TODO: Implement pagination
}

@end
