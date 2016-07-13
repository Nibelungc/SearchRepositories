//
//  NKRepositoryDataSource.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKRepositoryDataSource.h"
#import "NKRepositoryCell.h"
#import "NKRepository.h"
#import "NSArray+SQExtended.h"

static NSInteger kNumberOfSections = 1;

@interface NKRepositoryDataSource ()

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <NKRepository *>* items;

@end

@implementation NKRepositoryDataSource

#pragma mark - Initizlization

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _items = [@[] mutableCopy];
        _tableView = tableView;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self registerCells];
    self.tableView.estimatedRowHeight = [[self repositoryCellClass] standartHeight];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Public

- (NSUInteger)countOfItems {
    return self.items.count;
}

- (void)addItems:(NSArray <NKRepository *>*)items {
    [self.items addObjectsFromArray:items];
    [self itemsUpdated];
}

- (void)reloadWithItems:(NSArray <NKRepository *>*)items {
    self.items = [items mutableCopy];
    [self itemsUpdated];
}

- (NKRepository *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.items objectAtIndexOrNil:indexPath.row];
}

- (Class)repositoryCellClass {
    return [NKRepositoryCell class];
}

#pragma mark - Table View

- (void)itemsUpdated {
    [self.tableView reloadData];
}

#pragma mark - Cells

- (void)registerCells {
    Class cellClass = [self repositoryCellClass];
    NSString *nibName = [cellClass nibName];
    NSString *reusableIdentifier = [cellClass reusableIdentifier];
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reusableIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NKTableViewCell *cell = nil;
    Class cellClass = [self repositoryCellClass];
    NSString *reusableIdentifier = [cellClass reusableIdentifier];
    cell = [self.tableView dequeueReusableCellWithIdentifier:reusableIdentifier
                                                forIndexPath:indexPath];
    NKRepository *item = [self itemAtIndexPath:indexPath];
    [cell configureWithItem:item];
    return cell;
}

@end
