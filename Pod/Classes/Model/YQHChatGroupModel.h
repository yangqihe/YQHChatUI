//
//  YQHChatGroupModel.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 群组
 */

@interface YQHChatGroupModel : NSObject

/*!
 *  群组ID
 */
@property (nonatomic, strong) NSString *groupId;

/*!
 *  群组的主题，需要获取群详情
 */
@property (nonatomic, copy) NSString *subject;

/*!
 *  群组的描述，需要获取群详情
 */
@property (nonatomic, copy) NSString *groupDescription;

/*!
 *  群组的公告，需要获取群公告
 */
@property (nonatomic, copy) NSString *announcement;

/*!
 *  群组属性配置，需要获取群详情
 */
//@property (nonatomic, strong, readonly) EMGroupOptions *setting;

/*!
 *  群组的所有者，拥有群的最高权限，需要获取群详情
 *
 *  群组的所有者只有一人
 */
@property (nonatomic, copy) NSString *owner;

/*!
 *  群组的管理者，拥有群的最高权限，需要获取群详情
 *
 */
@property (nonatomic, copy) NSArray *adminList;

/*!
 *  群组的成员列表，需要获取群详情
 */
@property (nonatomic, copy) NSArray *memberList;

/*!
 *  群组的黑名单，需要先调用获取群黑名单方法
 *
 *  需要owner权限才能查看，非owner返回nil
 */
@property (nonatomic, strong) NSArray *blacklist;

/*!
 *  群组的被禁言列表
 *
 *  需要owner权限才能查看，非owner返回nil
 */
@property (nonatomic, strong) NSArray *muteList;

/*!
 *  群共享文件列表
 */
@property (nonatomic, strong) NSArray *sharedFileList;

/*!
 *  此群组是否接收消息推送通知
 */
@property (nonatomic) BOOL isPushNotificationEnabled;

/*!
 *  此群是否为公开群，需要获取群详情
 */
@property (nonatomic) BOOL isPublic;

/*!
 *  是否屏蔽群消息
 */
@property (nonatomic) BOOL isBlocked;

/*!
 *  当前登录账号的群成员类型
 */
//@property (nonatomic) EMGroupPermissionType permissionType;

/*!
 *  群组的所有成员(包含owner、admins和members)
 */
@property (nonatomic, strong) NSArray *occupants;

/*!
 *  群组当前的成员数量，需要获取群详情, 包括owner, admins, members
 */
@property (nonatomic) NSInteger occupantsCount;

/*!
 *  \~chinese
 *  获取群组实例，如果不存在则创建
 *
 *  @param aGroupId    群组ID
 *
 *  @result 群组实例
 */
//+ (instancetype)groupWithId:(NSString *)aGroupId;

@end

