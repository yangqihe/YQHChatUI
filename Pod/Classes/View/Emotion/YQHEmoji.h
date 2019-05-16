//
//  YQHEmoji.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YQHEmoji : NSObject

+ (NSString *)emojiWithCode:(int)code;

+ (NSArray *)allEmoji;

+ (BOOL)stringContainsEmoji:(NSString *)string;

@end

