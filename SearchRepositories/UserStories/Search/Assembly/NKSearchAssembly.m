//
//  NKSearchAssembly.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKSearchAssembly.h"
#import "NKSearchController.h"
#import "NKSearchPresenter.h"
#import "NKAPISearchService.h"
#import "NKUserDefaultsStorage.h"

@implementation NKSearchAssembly

- (NKSearchController *)searchView {
    return [TyphoonDefinition withClass:[NKSearchController class]
            configuration:^(TyphoonDefinition *definition) {
                [definition injectProperty:@selector(presenter)
                                      with:self.searchPresenter];
            }];
}

- (NKSearchPresenter *)searchPresenter {
    return [TyphoonDefinition withClass:[NKSearchPresenter class]
            configuration:^(TyphoonDefinition *definition) {
                [definition injectProperty:@selector(view)
                                      with:self.searchView];
                [definition injectProperty:@selector(searchService)
                                      with:self.serviceComponents.searchService];
                [definition injectProperty:@selector(localStorage)
                                      with:self.serviceComponents.localStorage];
                
            }];
}


@end
