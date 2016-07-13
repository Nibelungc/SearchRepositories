//
//  NSArray+SQExtended.m
//  Domopult
//
//  Created by Nikolay Kagala on 29/04/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import "NSArray+SQExtended.h"

@implementation NSArray (SQExtended)

- (id)objectAtIndexOrNil:(NSInteger)index {
    if (index >= 0 && index < self.count){
        return [self objectAtIndex: index];
    }
    return nil;
}

- (NSArray*)map:(id(^)(id obj))block {
    NSMutableArray* mappedArray = [[NSMutableArray alloc] initWithCapacity: self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id newObject = block(obj);
        if (newObject){
            [mappedArray addObject: newObject];
        } else {
            NSLog(@"Attempt to insert nil in an array while mapping");
        }
    }];
    return mappedArray;
}

@end
