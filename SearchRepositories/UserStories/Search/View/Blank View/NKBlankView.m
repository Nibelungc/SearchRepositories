//
//  NKBlankView.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKBlankView.h"

@interface NKBlankView ()

@property (weak, nonatomic) UILabel *messageLabel;

@property (assign, nonatomic) NKBlankViewState state;

@property (strong, nonatomic) NSMutableDictionary *stateMessages;

@end

@implementation NKBlankView

- (instancetype)initWithFrame:(CGRect)frame
          initialStateMessage:(NSString *)initialMessage
                 emptyMessage:(NSString *)emptyMessage{
    if (self = [super initWithFrame:frame]){
        _stateMessages = [@{@(NKBlankViewStateInitial): initialMessage?: @"",
                            @(NKBlankViewStateEmpty): emptyMessage?: @"",
                            @(NKBlankViewStateError): NSLocalizedString(@"error_title", nil)} mutableCopy];
        _state = NKBlankViewStateInitial;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setStateAndShow:(NKBlankViewState)state {
    [self setStateAndShow:state
              withMessage:[self messageForState:state]];
}

- (void)setStateAndShow:(NKBlankViewState)state withMessage:(nullable NSString *)message {
    self.state = state;
    [self updateLabelWithMessage:message];
    [self setHidden:NO animated:YES];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
    NSTimeInterval duration = animated ? .3f: .0f;
    CGFloat alpha = hidden ? .0f: 1.0f;
    [UIView animateWithDuration:duration
                     animations:^{
                         self.alpha = alpha;
                     }];
}

#pragma mark - Configuring view

- (NSString *)messageForState:(NKBlankViewState)state {
    return self.stateMessages[@(state)];
}

- (NSString *)messageForCurrentState {
    return [self messageForState:self.state];
}

- (void)updateLabelWithMessage:(NSString *)message {
    self.messageLabel.text = message;
}

- (void)updateLabelWithDefaultMessage {
    [self updateLabelWithMessage:[self messageForCurrentState]];
}

- (UILabel *)messageLabel {
    if (!_messageLabel){
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 0.5;
        [self addSubview:label];
        _messageLabel = label;
        [self updateLabelWithDefaultMessage];
    }
    return _messageLabel;
}

#pragma mark - Constraints

- (void)updateConstraints {
    [self addMessageLabelConstraints];
    [super updateConstraints];
}

- (void)addMessageLabelConstraints {
    NSAssert(self.superview, @"You need to add blank view as subview");
    UIView *view = self.superview;
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSInteger padding = 8;
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_messageLabel]-padding-|"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"padding": @(padding)}
                                               views:NSDictionaryOfVariableBindings(_messageLabel)]];
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[_messageLabel]-padding-|"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"padding": @(padding)}
                                               views:NSDictionaryOfVariableBindings(_messageLabel)]];
}

- (void)addConstraintsWithTopItem:(id)item {
    NKBlankView *blankView = self;
    UIView *view = blankView.superview;
    blankView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat blankHeight = 150.0;
    CGFloat blankWidth = 250.0;
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[blankView(==height)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"height": @(blankHeight)}
                                               views:NSDictionaryOfVariableBindings(blankView)]];
    [view addConstraint:
     [NSLayoutConstraint constraintWithItem:item
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:blankView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1.0
                                   constant:8.0]];
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[blankView(==width)]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:@{@"width": @(blankWidth)}
                                               views:NSDictionaryOfVariableBindings(blankView)]];
    [view addConstraint:
     [NSLayoutConstraint constraintWithItem:view
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:blankView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0]];
    [view layoutIfNeeded];
}

@end
