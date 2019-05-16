//
//  YQHChatCDDeviceManager.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol YQHChatCDDeviceManagerProximitySensorDelegate <NSObject>

- (void)proximitySensorChanged:(BOOL)isCloseToUser;

@end

@protocol YQHChatCDDeviceManagerDelegate <YQHChatCDDeviceManagerProximitySensorDelegate>

@end

@interface YQHChatCDDeviceManager : NSObject{
    // recorder
    NSDate              *_recorderStartDate;
    NSDate              *_recorderEndDate;
    NSString            *_currCategory;
    BOOL                _currActive;
    
    // proximitySensor
    BOOL _isSupportProximitySensor;
    BOOL _isCloseToUser;
}

@property (nonatomic, assign) id <YQHChatCDDeviceManagerDelegate> delegate;

+(YQHChatCDDeviceManager *)sharedInstance;

@end

