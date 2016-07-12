//
//  NKRepositoryDataSource.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NKRepository;

NS_ASSUME_NONNULL_BEGIN

@interface NKRepositoryDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)addItems:(NSArray <NKRepository *>*)items;

- (void)reloadWithItems:(NSArray <NKRepository *>*)items;

- (NKRepository *)itemAtIndexPath:(NSIndexPath *)indexPath;

- (Class)repositoryCellClass;

- (NSUInteger)countOfItems;

@end

NS_ASSUME_NONNULL_END