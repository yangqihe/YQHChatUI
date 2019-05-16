//
//  YQHEmotionManager.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHEmotionManager.h"

@implementation YQHEmotionManager

- (id)initWithType:(YQHEmotionType)Type
        emotionRow:(NSInteger)emotionRow
        emotionCol:(NSInteger)emotionCol
          emotions:(NSArray*)emotions
{
    self = [super init];
    if (self) {
        _emotionType = Type;
        _emotionRow = emotionRow;
        _emotionCol = emotionCol;
        NSMutableArray *tempEmotions = [NSMutableArray array];
        for (id name in emotions) {
            if ([name isKindOfClass:[NSString class]]) {
                YQHEmotion *emotion = [[YQHEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:YQHEmotionDefault];
                [tempEmotions addObject:emotion];
            }
        }
        _emotions = tempEmotions;
        _tagImage = nil;
    }
    return self;
}

- (id)initWithType:(YQHEmotionType)Type
        emotionRow:(NSInteger)emotionRow
        emotionCol:(NSInteger)emotionCol
          emotions:(NSArray*)emotions
          tagImage:(UIImage*)tagImage

{
    self = [super init];
    if (self) {
        _emotionType = Type;
        _emotionRow = emotionRow;
        _emotionCol = emotionCol;
        _emotions = emotions;
        _tagImage = tagImage;
    }
    return self;
}

@end

@implementation YQHEmotion

- (id)initWithName:(NSString*)emotionTitle
         emotionId:(NSString*)emotionId
  emotionThumbnail:(NSString*)emotionThumbnail
   emotionOriginal:(NSString*)emotionOriginal
emotionOriginalURL:(NSString*)emotionOriginalURL
       emotionType:(YQHEmotionType)emotionType
{
    self = [super init];
    if (self) {
        _emotionTitle = emotionTitle;
        _emotionId = emotionId;
        _emotionThumbnail = emotionThumbnail;
        _emotionOriginal = emotionOriginal;
        _emotionOriginalURL = emotionOriginalURL;
        _emotionType = emotionType;
    }
    return self;
}

@end
