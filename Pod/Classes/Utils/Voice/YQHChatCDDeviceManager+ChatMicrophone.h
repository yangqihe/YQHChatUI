//
//  YQHChatCDDeviceManager+ChatMicrophone.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager.h"

@interface YQHChatCDDeviceManager (ChatMicrophone)

// Check the availability for microphone
- (BOOL)emCheckMicrophoneAvailability;

// Get the audio volumn (0~1)
- (double)emPeekRecorderVoiceMeter;

@end
