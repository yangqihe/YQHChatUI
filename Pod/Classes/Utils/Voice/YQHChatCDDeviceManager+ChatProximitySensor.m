//
//  YQHChatCDDeviceManager+ChatProximitySensor.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager+ChatProximitySensor.h"

@implementation YQHChatCDDeviceManager (ChatProximitySensor)

@dynamic isSupportProximitySensor;
@dynamic isCloseToUser;


#pragma mark - proximity sensor
- (BOOL)isProximitySensorEnabled {
    BOOL ret = NO;
    ret = self.isSupportProximitySensor && [UIDevice currentDevice].proximityMonitoringEnabled;
    
    return ret;
}

- (BOOL)enableProximitySensor {
    BOOL ret = NO;
    if (_isSupportProximitySensor) {
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        ret = YES;
    }
    
    return ret;
}

- (BOOL)disableProximitySensor {
    BOOL ret = NO;
    if (_isSupportProximitySensor) {
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        _isCloseToUser = NO;
        ret = YES;
    }
    
    return ret;
}

- (void)sensorStateChanged:(NSNotification *)notification {
    BOOL ret = NO;
    if ([[UIDevice currentDevice] proximityState] == YES) {
        ret = YES;
    }
    _isCloseToUser = ret;
    if([self.delegate respondsToSelector:@selector(proximitySensorChanged:)]){
        [self.delegate proximitySensorChanged:_isCloseToUser];
    }
}

#pragma mark - getter
- (BOOL)isCloseToUser {
    return _isCloseToUser;
}

- (BOOL)isSupportProximitySensor {
    return _isSupportProximitySensor;
}

@end
