//
//  NSString+cal.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NSString+cal.h"

@implementation NSString (cal)

//计算文字的大小
- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //计算文本的大小
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return nameSize;
}

@end
