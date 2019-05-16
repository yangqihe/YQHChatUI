//
//  ChatConversationModel.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chatConst.h"

@interface YQHChatConversationModel : NSObject

//用户的UUID
@property(nonatomic, assign) SInt64 uid;

/**
 会话ID
 */
@property (nonatomic, strong) NSString *conversationId;

/**
 会话类型
 */
@property (nonatomic, assign) YQHChatType chatType;

/**
 会话的标题
 */
@property (strong, nonatomic) NSString *title;

/**
 会话的内容
 */
@property (strong, nonatomic) NSString *contentText;

/**
 会话的显示时间（最后一条消息时间格式化）
 */
@property (strong, nonatomic) NSString *timeText;

/**
 头像url
 */
@property (strong, nonatomic) NSString *avatarURLPath;

/**
 头像
 */
@property (strong, nonatomic) UIImage *avatarImage;

/**
 会话未读消息
 */
@property (nonatomic) int unreadMessagesCount;

/**
 扩展字段 以后可以当做透传字段类型
 */
@property (nonatomic, copy) NSDictionary *ext;

/**
 是否置顶  1 置顶
 */
@property (assign, nonatomic) int topState;

/**
 最后一条消息的时间戳（服务器时间）
 */
@property (nonatomic) long long lastMessageTimestamp;

/**
 标记该会话的消息状态为已读
 */
//- (void)markAllMessagesAsRead;



@end

