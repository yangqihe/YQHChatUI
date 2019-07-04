//
//  YQHBubbleView+File.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHBubbleView+File.h"

@implementation YQHBubbleView (File)

//CGFloat const YQHMessageCellPadding = 10;

#pragma mark - private

- (void)_setupFileBubbleMarginConstraints
{
    [self.marginConstraints removeAllObjects];
    
    //icon view
    NSLayoutConstraint *fileIconWithMarginTopConstraint = [NSLayoutConstraint constraintWithItem:self.fileIconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
    NSLayoutConstraint *fileIconWithMarginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.fileIconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    NSLayoutConstraint *fileIconWithMarginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.fileIconView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15];
    NSLayoutConstraint *fileIconWidthConstraint=[NSLayoutConstraint constraintWithItem:self.fileIconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45];
    [self.marginConstraints addObject:fileIconWidthConstraint];
    [self.marginConstraints addObject:fileIconWithMarginTopConstraint];
    [self.marginConstraints addObject:fileIconWithMarginBottomConstraint];
    [self.marginConstraints addObject:fileIconWithMarginLeftConstraint];
    
    //name label
    NSLayoutConstraint *fileNameWithMarginTopConstraint = [NSLayoutConstraint constraintWithItem:self.fileNameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
    NSLayoutConstraint *fileNameWithMarginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.fileNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15];
    NSLayoutConstraint *fileNameWithMarginRightConstraint=[NSLayoutConstraint constraintWithItem:self.fileNameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fileIconView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15];
    
    [self.marginConstraints addObject:fileNameWithMarginTopConstraint];
    [self.marginConstraints addObject:fileNameWithMarginLeftConstraint];
    [self.marginConstraints addObject:fileNameWithMarginRightConstraint];
    
    //size label
    NSLayoutConstraint *fileSizeWithMarginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.fileSizeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fileNameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:2];
    
    [self.marginConstraints addObject:fileSizeWithMarginBottomConstraint];
    
    
    NSLayoutConstraint *fileSizeLeftConstraint =[NSLayoutConstraint constraintWithItem:self.fileSizeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fileNameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *fileSizeTopConstraint = [NSLayoutConstraint constraintWithItem:self.fileSizeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fileNameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:2];
    
    [self.marginConstraints addObject:fileSizeLeftConstraint];
    [self.marginConstraints addObject:fileSizeTopConstraint];
    
    [self addConstraints:self.marginConstraints];
}

- (void)_setupFileBubbleConstraints
{
    [self _setupFileBubbleMarginConstraints];
    
    //icon view
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:self.fileIconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.fileIconView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:100]];
    
    //[self addConstraint:[NSLayoutConstraint constraintWithItem:self.fileIconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.fileIconView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:40]];
    
 //   [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fileNameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fileIconView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15]];
//
    
    
    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fileSizeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.fileNameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
////    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fileSizeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.fileNameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.fileSizeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.fileNameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:2]];
}

#pragma mark - public

- (void)setupFileBubbleView
{
    self.fileIconView = [[UIImageView alloc] init];
    self.fileIconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileIconView.backgroundColor = [UIColor clearColor];
    //self.fileIconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backgroundImageView addSubview:self.fileIconView];
    
    self.fileNameLabel = [[UILabel alloc] init];
    self.fileNameLabel.numberOfLines=2;
    self.fileNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileNameLabel.backgroundColor = [UIColor clearColor];
    [self.backgroundImageView addSubview:self.fileNameLabel];
    self.fileNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    //self.fileNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];

    
    self.fileSizeLabel = [[UILabel alloc] init];
    self.fileSizeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fileSizeLabel.backgroundColor = [UIColor clearColor];
    [self.backgroundImageView addSubview:self.fileSizeLabel];
    self.fileSizeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    //self.fileSizeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    
    [self _setupFileBubbleMarginConstraints];
}

- (void)updateFileMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    [self _setupFileBubbleMarginConstraints];
}

@end
