//
//  YQHChatAudioRecorderUtil.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface YQHChatAudioRecorderUtil : NSObject

+(BOOL)isRecording;

// Start recording
+ (void)asyncStartRecordingWithPreparePath:(NSString *)aFilePath
                                completion:(void(^)(NSError *error))completion;
// Stop recording
+(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath))completion;

// Cancel recording
+(void)cancelCurrentRecording;

// Current recorder
+(AVAudioRecorder *)recorder;

@end

