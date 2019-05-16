//
//  YQHBubbleView+Gif.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHBubbleView+Gif.h"

@implementation YQHBubbleView (Gif)

#pragma mark - private

- (void)_setupImageBubbleMarginConstraints
{
//    NSLayoutConstraint *marginTopConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
//    NSLayoutConstraint *marginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
//    NSLayoutConstraint *marginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
//    NSLayoutConstraint *marginRightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
    NSLayoutConstraint *marginTopConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *marginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *marginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *marginRightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];


    [self.marginConstraints removeAllObjects];
    [self.marginConstraints addObject:marginTopConstraint];
    [self.marginConstraints addObject:marginBottomConstraint];
    [self.marginConstraints addObject:marginLeftConstraint];
    [self.marginConstraints addObject:marginRightConstraint];

    [self addConstraints:self.marginConstraints];
    
//    self.imageView.frame = CGRectInset(self.backgroundImageView.frame, 0.0f, 0.0f);
//    self.imageView.layer.mask = self.backgroundImageView.layer;
}

- (void)_setupImageBubbleConstraints
{
    [self _setupImageBubbleMarginConstraints];
}

#pragma mark - public

- (void)setupGifBubbleView
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imageView];
    self.backgroundImageView.hidden = YES;
    
    [self _setupImageBubbleConstraints];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100]];
}

- (void)updateGifMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    [self _setupImageBubbleMarginConstraints];
}

@end
