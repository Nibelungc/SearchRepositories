//
//  PageLoadingIndicator.m
//  Domopult
//
//  Created by Nikolay Kagala on 13/05/16.
//  Copyright © 2016 sequenia. All rights reserved.
//

#import "PageLoadingIndicator.h"

static NSString* const kScrollContentSizeKeyPath = @"contentSize";

static CGFloat const kLoadingViewHeight = 60.0;

static UIActivityIndicatorViewStyle const kDefaultIndicatorStyle = UIActivityIndicatorViewStyleGray;

@interface PageLoadingIndicator ()

@property (weak, nonatomic) UITableView* tableView;

@property (strong, nonatomic) UIActivityIndicatorView* indicatorView;

@property (assign, nonatomic) UIEdgeInsets loadingInsets;

@end

@implementation PageLoadingIndicator

#pragma mark - Init

- (instancetype) initWithTableView: (UITableView*) tableView
                             style: (UIActivityIndicatorViewStyle) style {
    if (self = [super init]){
        self.tableView = tableView;
        self.style = style;
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithTableView: (UITableView*) tableView {
    return [self initWithTableView: tableView style: kDefaultIndicatorStyle];
}

- (void) commonInit {
    [self addObservers];
    self.loadingViewHeight = kLoadingViewHeight;
    self.originalInsets = self.tableView.contentInset;
    self.loadingInsets = self.originalInsets;
    self.loadingInsets = (UIEdgeInsets){
        .bottom = self.loadingViewHeight + self.originalInsets.bottom
    };
    [self scrollViewContentSizeDidChange:self.tableView];
}

#pragma mark - Deinit

- (void) dealloc {
    [self removeObservers];
}

#pragma mark - Control

#pragma mark -- Insets

- (void) setHidden: (BOOL) hidden animated: (BOOL) animated {
    if (hidden && [self isHidden]){
        return;
    }
    
    UIEdgeInsets insets = hidden ? self.originalInsets : self.loadingInsets;
    __weak typeof(self) wSelf = self;
    [self setHiddenIndicator: hidden
                    animated: animated
                  completion:^{
                      [UIView animateWithDuration: 0.3
                                       animations:^{
                                           __strong typeof(self) sSelf = wSelf;
                                           [sSelf.tableView setContentInset: insets];
                                       }];
                  }];
}

- (BOOL) isHidden {
    return UIEdgeInsetsEqualToEdgeInsets(self.tableView.contentInset, self.originalInsets);
}

#pragma mark -- Indicator

- (void) setLoading: (BOOL) loading {
    [self setHiddenIndicator: !loading animated: YES completion: nil];
}

- (void) setHiddenIndicator: (BOOL) hidden
                   animated: (BOOL) animated
                 completion: (void(^)()) completion {
    if (hidden && [self isHiddenIndicator]){
        return;
    }
    
    CGFloat animationDuration = animated ? 0.3 : 0.0;
    CGFloat alpha = hidden ? 0.0 : 1.0;
    [UIView animateWithDuration: animationDuration
                     animations:^{
                         self.indicatorView.alpha = alpha;
                     } completion:^(BOOL finished) {
                         if (completion){ completion(); }
                     }];

}

- (BOOL) isHiddenIndicator {
    return self.indicatorView.alpha == 0.0;
}

#pragma mark - Custom accessors

- (UIView *)indicatorView {
    if (!_indicatorView){
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_style];
        [_indicatorView startAnimating];
        [_tableView addSubview: _indicatorView];
        [self setHiddenIndicator: YES animated: NO completion: nil];
    }
    return _indicatorView;
}

#pragma mark - Events

- (void) scrollViewContentSizeDidChange: (UIScrollView*) scrollView {
    CGFloat height = scrollView.contentSize.height + self.loadingViewHeight;
    CGFloat y = height - self.loadingViewHeight/2.0;
    self.indicatorView.center = (CGPoint) {
        .x = scrollView.center.x,
        .y = y
    };
}

#pragma mark - Observing

- (void) addObservers {
    [self.tableView addObserver: self forKeyPath: kScrollContentSizeKeyPath options: kNilOptions context: nil];
}

- (void) removeObservers {
    [self.tableView removeObserver: self forKeyPath: kScrollContentSizeKeyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: kScrollContentSizeKeyPath]){
        [self scrollViewContentSizeDidChange: self.tableView];
    }
}


@end
