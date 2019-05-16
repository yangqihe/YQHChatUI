//
//  YQHBubbleView+Video.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHBubbleView+Video.h"

@implementation YQHBubbleView (Video)

#pragma mark - private

- (void)setupVideoBubbleMarginConstraints
{
    NSLayoutConstraint *marginTopConstraint = [NSLayoutConstraint constraintWithItem:self.videoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *marginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.videoImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    NSLayoutConstraint *marginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.videoImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginRightConstraint = [NSLayoutConstraint constraintWithItem:self.videoImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
    [self.marginConstraints removeAllObjects];
    
    [self.marginConstraints addObject:marginTopConstraint];
    [self.marginConstraints addObject:marginBottomConstraint];
    [self.marginConstraints addObject:marginLeftConstraint];
    [self.marginConstraints addObject:marginRightConstraint];
    
    [self addConstraints:self.marginConstraints];
}

- (void)setupVideoBubbleConstraints
{
    [self setupVideoBubbleMarginConstraints];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.videoImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.videoImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0.5 constant:40]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40]];
}

#pragma mark - public

- (void)setupVideoBubbleView
{
    self.videoImageView = [[UIImageView alloc] init];
    self.videoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.videoImageView.backgroundColor = [UIColor clearColor];
    self.videoImageView.layer.cornerRadius=5;
    self.videoImageView.layer.masksToBounds=YES;
    [self.backgroundImageView addSubview:self.videoImageView];
    
    self.videoTagView = [[UIImageView alloc] init];
    self.videoTagView.translatesAutoresizingMaskIntoConstraints = NO;
    self.videoTagView.backgroundColor = [UIColor clearColor];
    [self.videoImageView addSubview:self.videoTagView];
    
    [self setupVideoBubbleConstraints];
}

- (void)updateVideoMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    [self setupVideoBubbleMarginConstraints];
}

@end
