//
//  NKBlankView.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NKBlankViewState) {
    NKBlankViewStateInitial,
    NKBlankViewStateEmpty,
    NKBlankViewStateError
};

@interface NKBlankView : UIView

- (instancetype)initWithFrame:(CGRect)frame
          initialStateMessage:(NSString *)initialMessage
                 emptyMessage:(NSString *)emptyMessage;

- (void)setStateAndShow:(NKBlankViewState)state;

- (void)setStateAndShow:(NKBlankViewState)state withMessage:(nullable NSString *)message;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)addConstraintsWithTopItem:(id)item;

@end

NS_ASSUME_NONNULL_END
