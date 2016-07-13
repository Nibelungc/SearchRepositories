//
//  NKServicesAssembly.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKServicesAssembly.h"
#import "NKUserDefaultsStorage.h"
#import "NKAPISearchService.h"

@implementation NKServicesAssembly

- (id <NKSearchService>)searchService {
    return [TyphoonDefinition withClass:[NKAPISearchService class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(localStorage)
                                                    with:self.localStorage];
                          }];
}

- (id <NKLocalStorage>)localStorage {
    return [TyphoonDefinition withClass:[NKUserDefaultsStorage class]
                          configuration:^(TyphoonDefinition *definition) {
                              definition.scope = TyphoonScopeSingleton;
                          }];
}

@end
