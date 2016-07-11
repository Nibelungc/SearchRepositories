//
//  NKSearchController.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKSearchController.h"
#import "NKSearchViewOutput.h"

static CGFloat const kSearchAsYouTypeDelay = 0.5f;

@interface NKSearchController () <UISearchBarDelegate>

@property (strong, nonatomic) id<NKSearchViewOutput> presenter;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NKSearchController

@dynamic presenter;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
}

- (void)configureView {
    [super configureView];
}

#pragma mark - NKSearchViewInput

- (void)didFailSearchWithError:(NSError *)error {
    //TODO: Show an error of the search if it wasn't canceled
}

- (void)didFinishSearchWithResults:(NSArray <id>*)results {
    //TODO: Show a list of the results
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget: self selector: @selector(startSearch) object: nil];
    [self performSelector: @selector(startSearch) withObject: nil afterDelay: kSearchAsYouTypeDelay];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self startSearch];
}

#pragma mark - Actions

- (void)startSearch {
    [self.presenter didStartSearchingByString:self.searchBar.text];
}


@end
