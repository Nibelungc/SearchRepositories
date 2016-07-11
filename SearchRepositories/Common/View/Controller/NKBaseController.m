//
//  NKBaseController.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKBaseController.h"
#import "NKViewOutput.h"

@interface NKBaseController ()

@end

@implementation NKBaseController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    if ([self.presenter respondsToSelector:@selector(viewDidLoad)]){
        [self.presenter viewDidLoad];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.presenter respondsToSelector:@selector(viewWillAppear)]){
        [self.presenter viewWillAppear];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.presenter respondsToSelector:@selector(viewDidAppear)]){
        [self.presenter viewDidAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.presenter respondsToSelector:@selector(viewWillDisappear)]){
        [self.presenter viewWillDisappear];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.presenter respondsToSelector:@selector(viewDidDisappear)]){
        [self.presenter viewDidDisappear];
    }
}

#pragma mark - Configure view

- (void)configureView {
    //    Implement in subclass
}

#pragma mark - NKViewInput

@end
