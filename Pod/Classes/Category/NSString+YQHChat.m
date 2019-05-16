//
//  NSString+YQHChat.m
//  ioschat
//
//  Created by 杨棋贺 on 2019/4/3.
//  Copyright © 2019年 杨棋贺. All rights reserved.
//

#import "NSString+YQHChat.h"

@implementation NSString (YQHChat)

//计算文字的大小
- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //计算文本的大小
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return nameSize;
}

@end
