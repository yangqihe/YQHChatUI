//
//  YQHChatToolbarItem.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatToolbarItem.h"

@implementation YQHChatToolbarItem

- (instancetype)initWithButton:(UIButton *)button
                      withView:(UIView *)button2View
{
    self = [super init];
    if (self) {
        _button = button;
        _button2View = button2View;
    }
    
    return self;
}

@end
