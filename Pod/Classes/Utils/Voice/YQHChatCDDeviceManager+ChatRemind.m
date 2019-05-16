//
//  YQHChatCDDeviceManager+ChatRemind.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "YQHChatCDDeviceManager+ChatRemind.h"

void YQHSystemSoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    AudioServicesDisposeSystemSoundID(sound_id);
}

@implementation YQHChatCDDeviceManager (ChatRemind)

// The system sound for a new message
- (SystemSoundID)playNewMessageSound
{
    // Path for the audio file
    NSURL *bundlePath = [[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"];
    NSURL *audioPath = [[NSBundle bundleWithURL:bundlePath] URLForResource:@"in" withExtension:@"caf"];
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioPath), &soundID);
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(soundID,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          YQHSystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );
    
    AudioServicesPlaySystemSound(soundID);
    
    return soundID;
}

- (void)playVibration
{
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          YQHSystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
