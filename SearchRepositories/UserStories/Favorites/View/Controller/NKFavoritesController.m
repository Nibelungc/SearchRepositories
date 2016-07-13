//
//  NKFavoritesController.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKFavoritesController.h"
#import "NKFavoritesViewOutput.h"
#import "NKRepositoryDataSource.h"
#import "NKBlankView.h"

@interface NKFavoritesController () <UITableViewDelegate, NKRepositoryDataSourceDelegate>

@property (strong, nonatomic) id<NKFavoritesViewOutput> presenter;

@property (strong, nonatomic) NKRepositoryDataSource *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NKBlankView *blankView;

@end

@implementation NKFavoritesController

@dynamic presenter;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource.delegate = self;
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

#pragma mark - Configuring view

- (void)configureView {
    [super configureView];
    [self configureBlankView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)configureBlankView {
    NKBlankView *blankView =
    [[NKBlankView alloc] initWithFrame:CGRectZero
                   initialStateMessage:NSLocalizedString(@"", nil)
                          emptyMessage:NSLocalizedString(@"favorites_empty_state", nil)];
    [self.view addSubview: blankView];
    self.blankView = blankView;
    [self.blankView addConstraintsWithTopItem:self.topLayoutGuide];
}

#pragma mark - NKFavoritesViewInput

- (void)showItems:(NSArray <NKRepository *>*)items {
    [self.blankView setHidden:YES animated:NO];
    [self.dataSource reloadWithItems:items];
}

- (void)showEmptyState {
    [self.dataSource reloadWithItems:@[]];
    [self.blankView setStateAndShow:NKBlankViewStateEmpty];
}

#pragma mark - NKRepositoryDataSourceDelegate

- (void)dataSource:(NKRepositoryDataSource *)dataSource didRemoveItem:(NKRepository *)repository {
    [self.presenter removeItemFromFavorites:repository];
    if ([self.dataSource countOfItems] == 0){
        [self showEmptyState];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom accessors

- (NKRepositoryDataSource *)dataSource {
    if (!_dataSource){
        _dataSource = [[NKRepositoryDataSource alloc] initWithTableView:_tableView];
    }
    return _dataSource;
}


@end
