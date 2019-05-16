//
//  YQHChatCDDeviceManager+ChatRemind.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager.h"


@interface YQHChatCDDeviceManager (ChatRemind)

// The system sound for a new message
- (SystemSoundID)playNewMessageSound;

- (void)playVibration;

@end

