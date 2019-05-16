//
//  YQHChatImage.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/12.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQHChatImage : NSObject

/**
 聊天头像的默认背景
 */
//@property (nonatomic, assign) UIImage* chatMessageAvatarImageBg;

/**
 会话头像的默认背景
 */
@property (nonatomic, assign) UIImage* chatConversationAvatarImageSingleBg;

@property (nonatomic, assign) UIImage* chatConversationAvatarImageGroupBg;

@property (nonatomic, assign) UIImage* chatConversationAvatarImageRoomBg;

@end

