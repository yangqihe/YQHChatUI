//
//  YQHEmojiEmoticons.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHEmojiEmoticons.h"
#import "YQHEmoji.h"

@implementation YQHEmojiEmoticons

+ (NSArray *)allEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray * localAry = [[NSMutableArray alloc] initWithObjects:
                                 [YQHEmoji emojiWithCode:0x1F60a],
                                 [YQHEmoji emojiWithCode:0x1F603],
                                 [YQHEmoji emojiWithCode:0x1F609],
                                 [YQHEmoji emojiWithCode:0x1F62e],
                                 [YQHEmoji emojiWithCode:0x1F60b],
                                 [YQHEmoji emojiWithCode:0x1F60e],
                                 [YQHEmoji emojiWithCode:0x1F621],
                                 [YQHEmoji emojiWithCode:0x1F616],
                                 [YQHEmoji emojiWithCode:0x1F633],
                                 [YQHEmoji emojiWithCode:0x1F61e],
                                 [YQHEmoji emojiWithCode:0x1F62d],
                                 [YQHEmoji emojiWithCode:0x1F610],
                                 [YQHEmoji emojiWithCode:0x1F607],
                                 [YQHEmoji emojiWithCode:0x1F62c],
                                 [YQHEmoji emojiWithCode:0x1F606],
                                 [YQHEmoji emojiWithCode:0x1F631],
                                 [YQHEmoji emojiWithCode:0x1F385],
                                 [YQHEmoji emojiWithCode:0x1F634],
                                 [YQHEmoji emojiWithCode:0x1F615],
                                 [YQHEmoji emojiWithCode:0x1F637],
                                 [YQHEmoji emojiWithCode:0x1F62f],
                                 [YQHEmoji emojiWithCode:0x1F60f],
                                 [YQHEmoji emojiWithCode:0x1F611],
                                 [YQHEmoji emojiWithCode:0x1F496],
                                 [YQHEmoji emojiWithCode:0x1F494],
                                 [YQHEmoji emojiWithCode:0x1F319],
                                 [YQHEmoji emojiWithCode:0x1f31f],
                                 [YQHEmoji emojiWithCode:0x1f31e],
                                 [YQHEmoji emojiWithCode:0x1F308],
                                 [YQHEmoji emojiWithCode:0x1F60d],
                                 [YQHEmoji emojiWithCode:0x1F61a],
                                 [YQHEmoji emojiWithCode:0x1F48b],
                                 [YQHEmoji emojiWithCode:0x1F339],
                                 [YQHEmoji emojiWithCode:0x1F342],
                                 [YQHEmoji emojiWithCode:0x1F44d],
                                 nil];
    [array addObjectsFromArray:localAry];
    return array;
}
@end
