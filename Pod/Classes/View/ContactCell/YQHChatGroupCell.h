//
//  YQHChatGroupCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YQHChatGroupModel;

@interface YQHChatGroupCell : UITableViewCell

//头像
//@property (strong, nonatomic) UIImageView *avatarView;

@property (strong, nonatomic) YQHChatGroupModel *model;

-(void)calculateAvatarView:(NSArray *)group;

@end


