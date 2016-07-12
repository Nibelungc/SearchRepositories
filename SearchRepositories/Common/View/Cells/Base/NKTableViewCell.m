//
//  NKTableViewCell.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKTableViewCell.h"

@implementation NKTableViewCell

+ (NSString *)nibName {
    return NSStringFromClass([self class]);
}

+ (NSString *)reusableIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)standartHeight {
    return 80.0;
}

- (void)configureWithItem:(id)item {
    // Implement in subclass
}

@end
