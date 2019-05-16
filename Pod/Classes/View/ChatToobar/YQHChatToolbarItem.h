//
//  YQHChatToolbarItem.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YQHChatToolbarItem : NSObject

@property (strong, nonatomic, readonly) UIButton *button;

@property (strong, nonatomic) UIView *button2View;

- (instancetype)initWithButton:(UIButton *)button
                      withView:(UIView *)button2View;

@end

