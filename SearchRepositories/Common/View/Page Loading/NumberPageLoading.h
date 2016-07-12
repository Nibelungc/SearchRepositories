//
//  NumberPageLoading
//  Domopult
//
//  Created by Nikolay Kagala on 11/05/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PageLoading.h"

@interface NumberPageLoading : PageLoading

@property (assign, nonatomic, readonly) NSInteger firstPage;

@property (assign, nonatomic, readonly) NSInteger currentPage;

- (instancetype) initWithFirstPageIndex: (NSInteger) firstPage
                              tableView: (UITableView*) tableView;
/*!
 * Instantiated with default values: firstPage = 1
 */
- (instancetype) initWithTableView: (UITableView*) tableView;

@end
