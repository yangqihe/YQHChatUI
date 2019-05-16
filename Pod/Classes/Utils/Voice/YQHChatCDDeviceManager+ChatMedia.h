//
//  YQHChatCDDeviceManager+ChatMedia.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager.h"


@interface YQHChatCDDeviceManager (ChatMedia)

#pragma mark - AudioPlayer
// Play the audio
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon;
// Stop playing
- (void)stopPlaying;

- (void)stopPlayingWithChangeCategory:(BOOL)isChange;

-(BOOL)isPlaying;

#pragma mark - AudioRecorder
// Start recording
- (void)asyncStartRecordingWithFileName:(NSString *)fileName
                             completion:(void(^)(NSError *error))completion;

// Stop recording
-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath,
                                                 NSInteger aDuration,
                                                 NSError *error))completion;
// Cancel recording
-(void)cancelCurrentRecording;

-(BOOL)isRecording;

// Get the saved data path
+ (NSString*)dataPath;

@end

