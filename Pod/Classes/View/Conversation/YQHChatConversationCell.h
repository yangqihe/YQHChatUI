//
//  ChatConversationCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQHChatConversationModel.h"
#import "YQHImageView.h"

@interface YQHChatConversationCell : UITableViewCell

@property (strong, nonatomic) YQHChatConversationModel *model;

//头像
//@property (strong, nonatomic) UIImageView *avatarView;

//计算头像距离
-(void)calculateAvatarView:(NSArray *)group;

@end

