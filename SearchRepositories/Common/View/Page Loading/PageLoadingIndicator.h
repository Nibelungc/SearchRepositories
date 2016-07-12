//
//  PageLoadingIndicator.h
//  Domopult
//
//  Created by Nikolay Kagala on 13/05/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PageLoadingIndicator : NSObject

@property (assign, nonatomic) CGFloat loadingViewHeight;

@property (assign, nonatomic) UIEdgeInsets originalInsets;

@property (assign, nonatomic) UIActivityIndicatorViewStyle style;
/*!
 * Init with default indicator style UIActivityIndicatorViewStyleGray
 */
- (instancetype) initWithTableView: (UITableView*) tableView;

- (instancetype) initWithTableView: (UITableView*) tableView
                             style: (UIActivityIndicatorViewStyle) style;

- (void) setHidden: (BOOL) hidden animated: (BOOL) animated;

- (void) setLoading: (BOOL) loading;

- (BOOL) isHidden;

@end
