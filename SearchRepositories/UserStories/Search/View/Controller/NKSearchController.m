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
#import "NKBlankView.h"

static CGFloat const kSearchAsYouTypeDelay = 0.5f;

@interface NKSearchController () <UISearchBarDelegate, UITableViewDelegate>

@property (strong, nonatomic) id<NKSearchViewOutput> presenter;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NKBlankView *blankView;

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
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Configuring view

- (void)configureView {
    [super configureView];
    [self configureBlankView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.searchBar becomeFirstResponder];
}

- (void)configureBlankView {
    NKBlankView *blankView =
    [[NKBlankView alloc] initWithFrame:CGRectZero
                   initialStateMessage:NSLocalizedString(@"search_initial_state", nil)
                          emptyMessage:NSLocalizedString(@"search_empty_state", nil)];
    [self.view addSubview: blankView];
    self.blankView = blankView;
    [self.blankView addConstraintsWithTopItem:self.searchBar];
}

- (void)prepearForShowingBlankView {
    if ([self.dataSource countOfItems] != 0){
        [self.dataSource reloadWithItems:@[]];
    }
}

#pragma mark - NKSearchViewInput

- (void)didFailSearchWithError:(NSError *)error {
    [self.pageLoading loadingNewPageFailed];
    if ([self.dataSource countOfItems] == 0){
        [self prepearForShowingBlankView];
        [self.blankView setStateAndShow:NKBlankViewStateError withMessage:error.localizedDescription];
    }
    [self showError:error];
}

- (void)didFinishSearchWithResults:(NSArray <NKRepository *>*)results {
    if (results == nil) { return; }
    [self.dataSource reloadWithItems:results];
    [self.pageLoading loadingNewPageCompleted:results.count != 0];
    if (results.count == 0){
        [self prepearForShowingBlankView];
        [self.blankView setStateAndShow:NKBlankViewStateEmpty];
    }
    if ([self.dataSource countOfItems] > 0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
}

- (void)didLoadMoreResults:(NSArray <NKRepository *>*)results {
    if (results == nil) { return; }
    [self.dataSource addItems:results];
    [self.pageLoading loadingNewPageCompleted:results.count != 0];
}

- (void)didRemoveItemFromFavorites:(NKRepository *)item {
    [self.dataSource reloadItem:item];
}

- (void)didAddItemToFavorites:(NKRepository *)item {
    [self.dataSource reloadItem:item];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget: self selector: @selector(startSearch) object: nil];
    [self performSelector: @selector(startSearch) withObject: nil afterDelay: kSearchAsYouTypeDelay];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self startSearch];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.pageLoading needToLoadNewPageForIndexPath:indexPath]){
        [self.pageLoading loadingNewPageStarted];
        [self.presenter loadMoreData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.presenter didTapCellWithItem:[self.dataSource itemAtIndexPath:indexPath]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

#pragma mark - Actions

- (void)startSearch {
    NSString *searchString = self.searchBar.text;
    if ([searchString isEqualToString:@""]){
        [self prepearForShowingBlankView];
        [self.blankView setStateAndShow:NKBlankViewStateInitial];
        return;
    } else {
        [self.blankView setHidden:YES animated:YES];
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
