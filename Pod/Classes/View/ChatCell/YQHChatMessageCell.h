//
//  YQHBaseMessageCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQHBaseMessageCell.h"

extern NSString *const YQHMessageCellIdentifierSendText;
extern NSString *const YQHMessageCellIdentifierSendImage;
extern NSString *const YQHMessageCellIdentifierSendVoice;
extern NSString *const YQHMessageCellIdentifierSendVideo;

@interface YQHChatMessageCell : YQHBaseMessageCell
{
    //UILabel *_nameLabel;
}

@property (nonatomic) CGFloat avatarSize UI_APPEARANCE_SELECTOR; //default 30;

@property (nonatomic) CGFloat avatarCornerRadius UI_APPEARANCE_SELECTOR; //default 0;

@property (nonatomic) UIFont *messageNameFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:10];

@property (nonatomic) UIColor *messageNameColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor];

@property (nonatomic) CGFloat messageNameHeight UI_APPEARANCE_SELECTOR; //default 15;

@property (nonatomic) BOOL messageNameIsHidden UI_APPEARANCE_SELECTOR; //default NO;

@end

