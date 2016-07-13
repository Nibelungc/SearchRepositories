//
//  UIImage+NKApplicationImage.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "UIImage+NKApplicationImage.h"

@implementation UIImage (NKApplicationImage)

+ (UIImage *)nk_emptyStar {
    return [UIImage imageNamed:@"empty_star"];
}

+ (UIImage *)nk_star {
    return [UIImage imageNamed:@"star"];
}

@end
