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

static CGFloat const kSearchAsYouTypeDelay = 0.5f;

@interface NKSearchController () <UISearchBarDelegate>

@property (strong, nonatomic) id<NKSearchViewOutput> presenter;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NKRepositoryDataSource *dataSource;

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
}

- (void)configureView {
    [super configureView];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - NKSearchViewInput

- (void)didFailSearchWithError:(NSError *)error {
    //TODO: Show an error view instead of alert
    [self showError:error];
}

- (void)didFinishSearchWithResults:(NSArray <NKRepository *>*)results {
    //TODO: Scroll to top if needed
    if (results == nil) { return; }
    [self.dataSource reloadWithItems:results];
}

- (void)didLoadMoreResults:(NSArray <NKRepository *>*)results {
    if (results == nil) { return; }
    [self.dataSource addItems:results];
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
    //TODO: Validate search text
    [self.presenter didStartSearchingByString:self.searchBar.text];
}

#pragma mark - Custom accessors

- (NKRepositoryDataSource *)dataSource {
    if (!_dataSource){
        _dataSource = [[NKRepositoryDataSource alloc] initWithTableView:_tableView];
    }
    return _dataSource;
}


@end
