//
//  NSArray+SQExtended.h
//  Domopult
//
//  Created by Nikolay Kagala on 29/04/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SQExtended)

- (id)objectAtIndexOrNil:(NSInteger)index;

- (NSArray*)map:(id(^)(id obj))block;

@end
