//
//  NKTableViewCell.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKTableViewCell : UITableViewCell

+ (NSString *)nibName;

+ (NSString *)reusableIdentifier;

+ (CGFloat)standartHeight;

- (void)configureWithItem:(id)item;

@end
