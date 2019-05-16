//
//  YQHChatGroupMessageCell.h
//  AFNetworking
//
//  Created by 杨棋贺 on 2019/4/29.
//

#import <UIKit/UIKit.h>
#import "YQHBaseMessageCell.h"

extern NSString *const YQHMessageCellIdentifierSendText;
extern NSString *const YQHMessageCellIdentifierSendImage;
extern NSString *const YQHMessageCellIdentifierSendVoice;
extern NSString *const YQHMessageCellIdentifierSendVideo;

@interface YQHChatGroupMessageCell : YQHBaseMessageCell
{
    UILabel *_nameLabel;
}

@property (nonatomic) CGFloat avatarSize UI_APPEARANCE_SELECTOR; //default 30;

@property (nonatomic) CGFloat avatarCornerRadius UI_APPEARANCE_SELECTOR; //default 0;

@property (nonatomic) UIFont *messageNameFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:10];

@property (nonatomic) UIColor *messageNameColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor];

@property (nonatomic) CGFloat messageNameHeight UI_APPEARANCE_SELECTOR; //default 15;

@property (nonatomic) BOOL messageNameIsHidden UI_APPEARANCE_SELECTOR; //default NO;

@end
