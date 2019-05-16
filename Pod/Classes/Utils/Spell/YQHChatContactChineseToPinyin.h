//
//  YQHChatContactChineseToPinyin.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQHChatContactChineseToPinyin : NSObject

+ (NSString *)pinyinFromChineseString:(NSString *)string;

+ (char)sortSectionTitle:(NSString *)string;

@end
