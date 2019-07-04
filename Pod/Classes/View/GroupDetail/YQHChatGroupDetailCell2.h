//
//  YQHChatGroupDetailCell2.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YQHGroupItemDelegate <NSObject>

@optional

//1代表聊天置顶 2代表聊天不置顶 3代表清空记录   4  代表消息正常接收  5代表消息免打扰
-(void)itemClick:(int)index;

@end

@class YQHChatGroupModel;
@interface YQHChatGroupDetailCell2 : UITableViewCell

@property (nonatomic, strong) YQHChatGroupModel* chatGroupModel;

@property (nonatomic, weak)  id<YQHGroupItemDelegate> itemDelegate;

@property (nonatomic, strong) UISwitch *topChatConversationSwitch;

@property (nonatomic, strong) UISwitch *notDisturbSwitch;

@end

