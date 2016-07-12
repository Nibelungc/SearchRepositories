//
//  NKSearchController.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKSearchController.h"
#import "NKSearchViewOutput.h"
#import "NKRepositoryDataSource.h"
#import "NKTableViewCell.h"
#import "NumberPageLoading.h"

static CGFloat const kSearchAsYouTypeDelay = 0.5f;

@interface NKSearchController () <UISearchBarDelegate, UITableViewDelegate>

@property (strong, nonatomic) id<NKSearchViewOutput> presenter;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NKRepositoryDataSource *dataSource;

@property (strong, nonatomic) NumberPageLoading *pageLoading;

@end

@implementation NKSearchController

@dynamic presenter;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    self.tableView.dataSource = self.dataSource;
    self.tableView.estimatedRowHeight = [[self.dataSource repositoryCellClass] standartHeight];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
}

- (void)configureView {
    [super configureView];
    self.tableView.tableFooterView = [UIView new];
    [self.searchBar becomeFirstResponder];
}

#pragma mark - NKSearchViewInput

- (void)didFailSearchWithError:(NSError *)error {
    //TODO: Show an error view instead of alert
    [self.pageLoading loadingNewPageFailed];
    [self showError:error];
}

- (void)didFinishSearchWithResults:(NSArray <NKRepository *>*)results {
    //TODO: Scroll to top if needed
    if (results == nil) { return; }
    [self.dataSource reloadWithItems:results];
    [self.pageLoading loadingNewPageCompleted:results.count != 0];
}

- (void)didLoadMoreResults:(NSArray <NKRepository *>*)results {
    if (results == nil) { return; }
    [self.dataSource addItems:results];
    [self.pageLoading loadingNewPageCompleted:results.count != 0];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget: self selector: @selector(startSearch) object: nil];
    [self performSelector: @selector(startSearch) withObject: nil afterDelay: kSearchAsYouTypeDelay];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self startSearch];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.pageLoading needToLoadNewPageForIndexPath:indexPath]){
        [self.pageLoading loadingNewPageStarted];
        [self.presenter loadMoreData];
    }
}

#pragma mark - Actions

- (void)startSearch {
    NSString *searchString = self.searchBar.text;
    if ([searchString isEqualToString:@""]){
        [self.dataSource reloadWithItems:@[]];
        return;
    }
    [self.pageLoading loadingNewPageStarted];
    [self.presenter didStartSearchingByString:searchString];
}

#pragma mark - Custom accessors

- (NKRepositoryDataSource *)dataSource {
    if (!_dataSource){
        _dataSource = [[NKRepositoryDataSource alloc] initWithTableView:_tableView];
    }
    return _dataSource;
}

- (NumberPageLoading *)pageLoading {
    if (!_pageLoading){
        _pageLoading = [[NumberPageLoading alloc] initWithTableView:_tableView];
    }
    return _pageLoading;
}

@end
