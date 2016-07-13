//
//  NKServicesAssembly.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Typhoon/Typhoon.h>

@protocol NKSearchService;
@protocol NKLocalStorage;

@interface NKServicesAssembly : TyphoonAssembly

- (id <NKSearchService>)searchService;

- (id <NKLocalStorage>)localStorage;

@end
