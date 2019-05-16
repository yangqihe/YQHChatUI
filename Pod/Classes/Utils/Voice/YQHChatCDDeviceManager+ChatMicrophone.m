//
//  YQHChatCDDeviceManager+ChatMicrophone.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager+ChatMicrophone.h"
#import "YQHChatAudioRecorderUtil.h"

@implementation YQHChatCDDeviceManager (ChatMicrophone)

// Check the availability for microphone
- (BOOL)emCheckMicrophoneAvailability{
    __block BOOL ret = NO;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            ret = granted;
        }];
    } else {
        ret = YES;
    }
    
    return ret;
}

// Get the audio volumn (0~1)
- (double)emPeekRecorderVoiceMeter{
    double ret = 0.0;
    if ([YQHChatAudioRecorderUtil recorder].isRecording) {
        [[YQHChatAudioRecorderUtil recorder] updateMeters];
        //Average volumn  [recorder averagePowerForChannel:0];
        //Maximum volumn  [recorder peakPowerForChannel:0];
        double lowPassResults = pow(10, (0.05 * [[YQHChatAudioRecorderUtil recorder] peakPowerForChannel:0]));
        ret = lowPassResults;
    }
    
    return ret;
}

@end
