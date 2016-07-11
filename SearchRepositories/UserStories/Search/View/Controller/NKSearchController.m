//
//  NKSearchController.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKSearchController.h"
#import "NKSearchViewOutput.h"

@interface NKSearchController ()

@property (strong, nonatomic) id<NKSearchViewOutput> presenter;

@end

@implementation NKSearchController

@dynamic presenter;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configureView {
    [super configureView];
}

#pragma mark - NKSearchViewOutput

- (void)didFailSearchWithError:(NSError *)error {
    //TODO: Show an error of the search if it wasn't canceled
}

- (void)didFinishSearchWithResults:(NSArray <id>*)results {
    //TODO: Show a list of the results
}


@end
