//
//  NKViewOutput.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NKViewOutput <NSObject>

@optional

- (void)viewDidLoad;

- (void)viewWillAppear;

- (void)viewDidAppear;

- (void)viewWillDisappear;

- (void)viewDidDisappear;

@end

NS_ASSUME_NONNULL_END
