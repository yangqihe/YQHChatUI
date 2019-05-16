//
//  NSDate+YQHChat.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (YQHChat)

/**
 计算指定时间与当前的时间差
 */
- (NSString *)getFormatterTime:(long)time;

-(NSString *)formattedTime;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;


@end

