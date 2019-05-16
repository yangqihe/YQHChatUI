//
//  YQHChatUserDetailCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQHChatContactModel;
@interface YQHChatUserDetailCell : UITableViewCell

@property (nonatomic, strong) YQHChatContactModel* contactModel;

//头像
@property (strong, nonatomic) UIImageView *avatarView;

//姓名
@property (strong, nonatomic) UILabel *nameLabel;

//教师级别 标签
@property (strong, nonatomic) UIImageView *gradeIcon;

//教师级别
@property (strong, nonatomic) UILabel *gradeLabel;

@end

