//
//  NKFavoritesAssembly.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKFavoritesAssembly.h"
#import "NKFavoritesController.h"
#import "NKFavoritesPresenter.h"
#import "NKUserDefaultsStorage.h"

@implementation NKFavoritesAssembly

- (NKFavoritesController *)favoritesView {
    return [TyphoonDefinition withClass:[NKFavoritesController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(presenter)
                                                    with:self.favoritesPresenter];
                          }];
}

- (NKFavoritesPresenter *)favoritesPresenter {
    return [TyphoonDefinition withClass:[NKFavoritesPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:self.favoritesView];
                              [definition injectProperty:@selector(localStorage)
                                                    with:self.serviceComponents.localStorage];
                              
                          }];
}

@end
