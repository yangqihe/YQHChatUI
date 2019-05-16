//
//  YQHChatCDDeviceManager+ChatProximitySensor.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager.h"


@interface YQHChatCDDeviceManager (ChatProximitySensor)

#pragma mark - proximity sensor
@property (nonatomic, readonly) BOOL isSupportProximitySensor;
@property (nonatomic, readonly) BOOL isCloseToUser;
@property (nonatomic, readonly) BOOL isProximitySensorEnabled;

- (BOOL)enableProximitySensor;
- (BOOL)disableProximitySensor;
- (void)sensorStateChanged:(NSNotification *)notification;

@end

