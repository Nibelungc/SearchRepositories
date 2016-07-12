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
    self.tableView.estimatedRowHeight = [[self.dataSource repositoryCellClass] standartHeight];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
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
    
    blankView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat blankHeight = 150.0;
    CGFloat blankWidth = 250.0;
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[blankView(==height)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"height": @(blankHeight)}
                                               views:NSDictionaryOfVariableBindings(blankView)]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.searchBar
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:blankView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1.0
                                   constant:8.0]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[blankView(==width)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"width": @(blankWidth)}
                                               views:NSDictionaryOfVariableBindings(blankView)]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.searchBar
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:blankView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0]];
    [self.view layoutIfNeeded];
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
    //TODO: Scroll to top if needed
    if (results == nil) { return; }
    [self.dataSource reloadWithItems:results];
    [self.pageLoading loadingNewPageCompleted:results.count != 0];
    if (results.count == 0){
        [self prepearForShowingBlankView];
        [self.blankView setStateAndShow:NKBlankViewStateEmpty];
    }
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
