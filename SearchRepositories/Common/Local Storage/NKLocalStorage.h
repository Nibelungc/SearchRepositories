//
//  NKLocalStorage.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const NKLocalStorageItemDidRemoveNotification;

extern NSString * const NKLocalStorageItemDidAddNotification;

extern NSString * const NKLocalStorageItemKey;

@protocol NKLocalStorage <NSObject>

@required

- (void)addItem:(id)item;

- (void)removeItem:(id)item;

- (nullable NSArray <id>*)getItemsWithClass:(Class)clazz;

- (BOOL)containsItem:(id)item;

@end

NS_ASSUME_NONNULL_END
