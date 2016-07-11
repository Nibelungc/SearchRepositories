//
//  NKBaseController.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKViewInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NKViewOutput;

@interface NKBaseController : UIViewController <NKViewInput>

@property (strong, nonatomic) id <NKViewOutput> presenter;

@end

NS_ASSUME_NONNULL_END