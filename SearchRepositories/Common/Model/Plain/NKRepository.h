//
//  NKRepository.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface NKRepository : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber *identifier;

@property (copy, nonatomic, readonly) NSString *name;

@property (copy, nonatomic, readonly) NSString *fullName;

@property (copy, nonatomic, readonly) NSString *HTMLURL;

@property (copy, nonatomic, readonly, nullable) NSString *descr;

@property (copy, nonatomic, readonly) NSDate *createdAt;

@property (copy, nonatomic, readonly) NSDate *updatedAt;

@property (copy, nonatomic, readonly, nullable) NSString *homepage;

@property (copy, nonatomic, readonly) NSNumber *stargazersCount;

@property (copy, nonatomic, readonly, nullable) NSString *language;

@property (copy, nonatomic, readonly) NSNumber *forksCount;

@property (assign, nonatomic, getter=isFavorite) BOOL favorite;

@end

NS_ASSUME_NONNULL_END
