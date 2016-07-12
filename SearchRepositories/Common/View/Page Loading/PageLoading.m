//
//  PageLoading.m
//  Domopult
//
//  Created by Nikolay Kagala on 12/05/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import "PageLoading.h"
#import "PageLoadingIndicator.h"

@interface PageLoading ()

@property (weak, nonatomic) UITableView* tableView;

@property (strong, nonatomic) PageLoadingIndicator* loadingIndicator;

@end

@implementation PageLoading

#pragma mark - Initalization

- (instancetype) initWithTableView: (UITableView*) tableView
                  loadingIndicator: (BOOL) show {
    if (self = [super init]){
        self.tableView = tableView;
        self.showLoadingIndicator = show;
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithTableView: (UITableView*) tableView {
    return [self initWithTableView: tableView loadingIndicator: YES];
}

- (void) commonInit {
    self.loadingIndicatorStyle = UIActivityIndicatorViewStyleGray;
}

#pragma mark - Loading Events

- (void) loadingNewPageStarted {
    [self.loadingIndicator setHidden: !self.showLoadingIndicator animated: YES];
    self.isLoading = YES;
}

- (void) loadingNewPageFailed {
    self.isLoading = NO;
}

- (void) loadingNewPageCompleted: (BOOL) hasNextPage {
    self.hasNextPage = hasNextPage;
    if (!hasNextPage){
        [self.loadingIndicator setHidden: YES animated: YES];
    } 
    self.isLoading = NO;
}

#pragma mark - Conditions

- (BOOL) isLastItemAtIndexPath: (NSIndexPath*) indexPath {
    NSInteger countOfSections = [self.tableView.dataSource numberOfSectionsInTableView: self.tableView];
    if (countOfSections - 1 != indexPath.section){
        return NO;
    }
    NSInteger countOfItemsInSection = [self.tableView.dataSource tableView: self.tableView
                                                     numberOfRowsInSection: indexPath.section];
    if (countOfItemsInSection - 1 != indexPath.row){
        return NO;
    }
    return YES;
}

- (BOOL) needToLoadNewPageForIndexPath: (NSIndexPath*) indexPath{
    if (![self isLastItemAtIndexPath: indexPath]){
        return NO;
    }
    if (!self.hasNextPage){
        return NO;
    }
    if (self.isLoading) {
        return NO;
    }
    return YES;
}

#pragma mark - Custom accessors

- (PageLoadingIndicator *)loadingIndicator {
    if (!_loadingIndicator){
        _loadingIndicator = [[PageLoadingIndicator alloc] initWithTableView: _tableView];
        _loadingIndicator.style = self.loadingIndicatorStyle;
    }
    return _loadingIndicator;
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    [self loadingStateChanged];
}

#pragma mark - Custom accessors helpers

- (void) loadingStateChanged {
    if (_showLoadingIndicator){
        [self.loadingIndicator setLoading: _isLoading];
    } else if (!_isLoading){
        [self.loadingIndicator setLoading: NO];
    }
}

@end
