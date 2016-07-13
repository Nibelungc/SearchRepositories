//
//  NKBaseAssembly.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 13/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import "NKServicesAssembly.h"

@interface NKBaseAssembly : TyphoonAssembly

@property (strong, nonatomic) NKServicesAssembly *serviceComponents;

@end
