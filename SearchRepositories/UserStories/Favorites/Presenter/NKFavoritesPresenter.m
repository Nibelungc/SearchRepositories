//
//  NKFavoritesPresenter.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKFavoritesPresenter.h"
#import "NKFavoritesViewInput.h"
#import "NKLocalStorage.h"

@interface NKFavoritesPresenter ()

@property (weak, nonatomic) id <NKFavoritesViewInput> view;

@end

@implementation NKFavoritesPresenter

@dynamic view;

#pragma mark - NKFavoritesViewOutput

- (void)viewDidLoad {

}

@end
