//
//  YQHEmotionManager.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, YQHEmotionType) {
    YQHEmotionDefault = 0,
    YQHEmotionPng,
    YQHEmotionGif
};

@interface YQHEmotionManager : NSObject

@property (nonatomic, strong) NSArray *emotions;

/*!
 @property
 @brief number of lines of emotion
 */
@property (nonatomic, assign) NSInteger emotionRow;

/*!
 @property
 @brief number of columns of emotion
 */
@property (nonatomic, assign) NSInteger emotionCol;

/*!
 @property
 @brief emotion type
 */
@property (nonatomic, assign) YQHEmotionType emotionType;

@property (nonatomic, strong) UIImage *tagImage;

- (id)initWithType:(YQHEmotionType)Type
        emotionRow:(NSInteger)emotionRow
        emotionCol:(NSInteger)emotionCol
          emotions:(NSArray*)emotions;

- (id)initWithType:(YQHEmotionType)Type
        emotionRow:(NSInteger)emotionRow
        emotionCol:(NSInteger)emotionCol
          emotions:(NSArray*)emotions
          tagImage:(UIImage*)tagImage;

@end


@interface YQHEmotion : NSObject

@property (nonatomic, assign) YQHEmotionType emotionType;

@property (nonatomic, copy) NSString *emotionTitle;

@property (nonatomic, copy) NSString *emotionId;

@property (nonatomic, copy) NSString *emotionThumbnail;

@property (nonatomic, copy) NSString *emotionOriginal;

@property (nonatomic, copy) NSString *emotionOriginalURL;

- (id)initWithName:(NSString*)emotionTitle
         emotionId:(NSString*)emotionId
  emotionThumbnail:(NSString*)emotionThumbnail
   emotionOriginal:(NSString*)emotionOriginal
emotionOriginalURL:(NSString*)emotionOriginalURL
       emotionType:(YQHEmotionType)emotionType;

@end
