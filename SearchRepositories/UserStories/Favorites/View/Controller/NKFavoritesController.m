//
//  NKFavoritesController.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKFavoritesController.h"
#import "NKFavoritesViewOutput.h"

@interface NKFavoritesController ()

@property (strong, nonatomic) id<NKFavoritesViewOutput> presenter;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NKFavoritesController

@dynamic presenter;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
