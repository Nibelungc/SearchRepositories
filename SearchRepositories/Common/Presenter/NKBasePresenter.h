//
//  NKBasePresenter.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libextobjc/EXTScope.h>
#import "NKViewOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NKViewInput;

@interface NKBasePresenter : NSObject <NKViewOutput>

@property (weak, nonatomic, nullable) id <NKViewInput> view;

@end

NS_ASSUME_NONNULL_END
