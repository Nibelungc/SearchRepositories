//
//  PageLoading.h
//  Domopult
//
//  Created by Nikolay Kagala on 12/05/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 * It's an abstract class, don't use it directly. Use instead one of subclasses NumberPageLoading or DatePageLoading
 */

@interface PageLoading : NSObject

@property (assign, nonatomic, readwrite) BOOL hasNextPage;

@property (assign, nonatomic, readonly) BOOL isLoading;

@property (assign, nonatomic) BOOL showLoadingIndicator;

@property (assign, nonatomic) UIActivityIndicatorViewStyle loadingIndicatorStyle;

- (instancetype) initWithTableView: (UITableView*) tableView
                  loadingIndicator: (BOOL) showLoadingIndicator;
/*!
 * Init with loading indicator by default
 */
- (instancetype) initWithTableView: (UITableView*) tableView;

- (BOOL) needToLoadNewPageForIndexPath: (NSIndexPath*) indexPath;

- (void) loadingNewPageStarted;

- (void) loadingNewPageFailed;

- (void) loadingNewPageCompleted: (BOOL) hasNextPage;

@end
