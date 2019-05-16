//
//  YQHChatAudioPlayerUtil.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQHChatAudioPlayerUtil : NSObject

+ (BOOL)isPlaying;

// Get the path of what is currently being played
+ (NSString *)playingFilePath;

// Play the audio（wav）from the path
+ (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon;

+ (void)stopCurrentPlaying;

@end

