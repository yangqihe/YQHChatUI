//
//  YQHChatMessageDelegate.h
//  AliyunOSSiOS
//
//  Created by 杨棋贺 on 2019/5/7.
//

#import <Foundation/Foundation.h>

@class YQHChatMessageModel;
@class YQHBaseMessageCell;

@protocol YQHMessageCellDelegate <NSObject>

@optional

- (void)messageCellSelected:(YQHChatMessageModel*)model withMessageCell:(UITableViewCell*)messageCell;;

- (void)statusButtonSelcted:(YQHChatMessageModel*)model withMessageCell:(UITableViewCell*)messageCell;

- (void)avatarViewSelcted:(YQHChatMessageModel*)model;

@end

@interface YQHChatMessageDelegate : NSObject

@end

