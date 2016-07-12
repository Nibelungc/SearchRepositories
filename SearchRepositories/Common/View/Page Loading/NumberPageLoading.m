//
//  NumberPageLoading
//  Domopult
//
//  Created by Nikolay Kagala on 11/05/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import "NumberPageLoading.h"

static NSInteger const kDefaultFirstPageIndex = 1;

@interface NumberPageLoading ()

@property (assign, nonatomic, readwrite) NSInteger firstPage;

@property (assign, nonatomic, readwrite) NSInteger currentPage;

@end

@implementation NumberPageLoading

- (instancetype) initWithFirstPageIndex: (NSInteger) firstPage
                              tableView: (UITableView*) tableView { 
    if (self = [super initWithTableView: tableView]){
        self.firstPage = firstPage;
        self.currentPage = firstPage;
    }
    return self;
}

- (instancetype) initWithTableView: (UITableView*) tableView {
    return [self initWithFirstPageIndex: kDefaultFirstPageIndex
                              tableView: tableView];
}


- (void) loadingNewPageCompleted: (BOOL) hasNextPage {
    [super loadingNewPageCompleted: hasNextPage];
    self.currentPage += 1;
}

@end
