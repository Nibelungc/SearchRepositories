//
//  UIColor+NKApplicationColor.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "UIColor+NKApplicationColor.h"

#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define UIColorFromRGB(r,g,b) UIColorFromRGBA(r,g,b,1.f)

@implementation UIColor (NKApplicationColor)

+ (UIColor *)nk_blue {
    return UIColorFromRGB(64, 120, 192);
}

+ (UIColor *)nk_gray {
    return UIColorFromRGB(136, 136, 136);
}

+ (UIColor *)nk_lightGray {
    return UIColorFromRGB(200, 200, 200);
}

+ (UIColor *)nk_darkGray {
    return UIColorFromRGB(102, 102, 102);
}

@end
