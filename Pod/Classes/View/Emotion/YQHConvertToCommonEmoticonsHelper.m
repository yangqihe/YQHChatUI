//
//  YQHConvertToCommonEmoticonsHelper.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHConvertToCommonEmoticonsHelper.h"
#import "YQHEmoji.h"

@implementation YQHConvertToCommonEmoticonsHelper

#pragma mark - emotics

+ (NSString *)convertToCommonEmoticons:(NSString *)text
{
    int allEmoticsCount = (int)[YQHEmoji allEmoji].count;
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😊"
                                 withString:@"[):]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😃"
                                 withString:@"[:D]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😉"
                                 withString:@"[;)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😮"
                                 withString:@"[:-o]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😋"
                                 withString:@"[:p]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😎"
                                 withString:@"[(H)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😡"
                                 withString:@"[:@]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😖"
                                 withString:@"[:s]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😳"
                                 withString:@"[:$]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😞"
                                 withString:@"[:(]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😭"
                                 withString:@"[:'(]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😐"
                                 withString:@"[:|]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😇"
                                 withString:@"[(a)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😬"
                                 withString:@"[8o|]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😆"
                                 withString:@"[8-|]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😱"
                                 withString:@"[+o(]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎅"
                                 withString:@"[<o)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😴"
                                 withString:@"[|-)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😕"
                                 withString:@"[*-)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😷"
                                 withString:@"[:-#]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😯"
                                 withString:@"[:-*]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😏"
                                 withString:@"[^o)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😑"
                                 withString:@"[8-)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💖"
                                 withString:@"[(|)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💔"
                                 withString:@"[(u)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌙"
                                 withString:@"[(S)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌟"
                                 withString:@"[(*)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌞"
                                 withString:@"[(#)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌈"
                                 withString:@"[(R)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😚"
                                 withString:@"[(})]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😍"
                                 withString:@"[({)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💋"
                                 withString:@"[(k)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌹"
                                 withString:@"[(F)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🍂"
                                 withString:@"[(W)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👍"
                                 withString:@"[(D)]"
                                    options:NSLiteralSearch
                                      range:range];
    }
    
    return retText;
}

+ (NSString *)convertToSystemEmoticons:(NSString *)text
{
    if (![text isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    if ([text length] == 0) {
        return @"";
    }
    int allEmoticsCount = (int)[[YQHEmoji allEmoji] count];
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[):]"
                                 withString:@"😊"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:D]"
                                 withString:@"😃"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[;)]"
                                 withString:@"😉"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-o]"
                                 withString:@"😮"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:p]"
                                 withString:@"😋"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(H)]"
                                 withString:@"😎"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:@]"
                                 withString:@"😡"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:s]"
                                 withString:@"😖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:$]"
                                 withString:@"😳"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:(]"
                                 withString:@"😞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:'(]"
                                 withString:@"😭"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:|]"
                                 withString:@"😐"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(a)]"
                                 withString:@"😇"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8o|]"
                                 withString:@"😬"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8-|]"
                                 withString:@"😆"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[+o(]"
                                 withString:@"😱"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[<o)]"
                                 withString:@"🎅"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[|-)]"
                                 withString:@"😴"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[*-)]"
                                 withString:@"😕"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-#]"
                                 withString:@"😷"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-*]"
                                 withString:@"😯"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[^o)]"
                                 withString:@"😏"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8-)]"
                                 withString:@"😑"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(|)]"
                                 withString:@"💖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(u)]"
                                 withString:@"💔"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(S)]"
                                 withString:@"🌙"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(*)]"
                                 withString:@"🌟"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(#)]"
                                 withString:@"🌞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(R)]"
                                 withString:@"🌈"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[(})]"
                                 withString:@"😚"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[({)]"
                                 withString:@"😍"
                                    options:NSLiteralSearch
                                      range:range];
        
        
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(k)]"
                                 withString:@"💋"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(F)]"
                                 withString:@"🌹"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(W)]"
                                 withString:@"🍂"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(D)]"
                                 withString:@"👍"
                                    options:NSLiteralSearch
                                      range:range];
    }
    
    return retText;
}

@end
