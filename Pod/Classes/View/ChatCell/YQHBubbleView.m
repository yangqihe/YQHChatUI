//
//  YQHBubbleView.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHBubbleView.h"


@interface YQHBubbleView()

@property (nonatomic) NSLayoutConstraint *marginTopConstraint;
@property (nonatomic) NSLayoutConstraint *marginBottomConstraint;
@property (nonatomic) NSLayoutConstraint *marginLeftConstraint;
@property (nonatomic) NSLayoutConstraint *marginRightConstraint;

@end

@implementation YQHBubbleView

@synthesize backgroundImageView = _backgroundImageView;
@synthesize margin = _margin;

- (instancetype)initWithMargin:(UIEdgeInsets)margin isSender:(BOOL)isSender{
    self = [super init];
    if (self) {
        _isSender = isSender;
        _margin=UIEdgeInsetsMake(0, 0, 0, 0);
        _marginConstraints = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Setup Constraints

- (void)setupBackgroundImageViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
}

#pragma mark - getter

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundImageView];
        [self setupBackgroundImageViewConstraints];
    }
    
    return _backgroundImageView;
}

@end
