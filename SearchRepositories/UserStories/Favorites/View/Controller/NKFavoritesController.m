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

@interface NKFavoritesController () <UITableViewDelegate>

@property (strong, nonatomic) id<NKFavoritesViewOutput> presenter;

@property (strong, nonatomic) NKRepositoryDataSource *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NKFavoritesController

@dynamic presenter;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

#pragma mark - Configuring view

- (void)configureView {
    [super configureView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - NKFavoritesViewInput

- (void)showItems:(NSArray <NKRepository *>*)items {
    [self.dataSource reloadWithItems:items];
}

- (void)showEmptyState {
    [self.dataSource reloadWithItems:@[]];
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
