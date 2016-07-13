//
//  NKUserDefaultsStorage.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKUserDefaultsStorage.h"

NSString * const NKLocalStorageItemDidRemoveNotification = @"NKLocalStorageItemDidRemoveNotification";

NSString * const NKLocalStorageItemDidAddNotification = @"NKLocalStorageItemDidAddNotification";

NSString * const NKLocalStorageItemKey = @"NKLocalStorageItemKey";

@interface NKUserDefaultsStorage ()

@property (strong, nonatomic) NSMutableDictionary <NSString*, NSMutableOrderedSet <id>*> *allItems;

@property (strong, nonatomic) NSUserDefaults *defaults;

@property (strong, nonatomic) NSNotificationCenter *notificationCenter;

@end

@implementation NKUserDefaultsStorage

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _allItems = [@{} mutableCopy];
        _defaults = [NSUserDefaults standardUserDefaults];
        _notificationCenter = [NSNotificationCenter defaultCenter];
        [self addNotificationsObserver];
    }
    return self;
}

- (void)dealloc {
    [self removeNotificationsObserver];
}

#pragma mark - Public

- (BOOL)containsItem:(id)item {
    NSMutableOrderedSet <id>* items = [self getItemsSetWithClass:[item class]];
    return [items containsObject:item];
}

- (void)addItem:(id)item {
    NSAssert([item conformsToProtocol:@protocol(NSCoding)],
             @"NKUserDefaultsStorage works only with objects that conform NSCoding protocol");
    if (item == nil) { return; }
    NSMutableOrderedSet <id>* items = [self getItemsSetWithClass:[item class]];
    [items addObject:item];
    [self.notificationCenter postNotificationName:NKLocalStorageItemDidAddNotification
                                           object:self
                                         userInfo:@{NKLocalStorageItemKey: item}];
}

- (void)removeItem:(id)item {
    if (item == nil) { return; }
    NSMutableOrderedSet <id>* items = [self getItemsSetWithClass:[item class]];
    [items removeObject:item];
    [self.notificationCenter postNotificationName:NKLocalStorageItemDidRemoveNotification
                                           object:self
                                         userInfo:@{NKLocalStorageItemKey: item}];
}

- (nullable NSArray <id>*)getItemsWithClass:(Class)clazz {
    return [[self getItemsSetWithClass:clazz] array];
}

#pragma mark - Notification

- (void)addNotificationsObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(save)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)removeNotificationsObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Save/Load

- (nullable NSMutableOrderedSet <id>*)getItemsSetWithClass:(Class)clazz {
    NSString *key = NSStringFromClass(clazz);
    if (self.allItems[key] == nil){
        self.allItems[key] = [self loadItemsByKey:key] ?: [NSMutableOrderedSet orderedSet];
    }
    return self.allItems[key];
}

- (NSMutableOrderedSet <id>*)loadItemsByKey:(NSString *)key {
    NSData *data = [self.defaults objectForKey:key];
    return [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
}

- (void)saveItems:(NSMutableOrderedSet <id>*)items byKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items];
    [self.defaults setObject:data forKey:key];
}

- (void)save {
    for (NSString *key in self.allItems.allKeys) {
        NSMutableOrderedSet *set = self.allItems[key];
        [self saveItems:set byKey:key];
    }
    [self.defaults synchronize];
}

@end
