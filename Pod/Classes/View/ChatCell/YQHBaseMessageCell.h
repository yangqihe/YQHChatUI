//
//  YQHMessageCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQHChatMessageDelegate.h"

//@protocol YQHMessageCellDelegate;
@class YQHBubbleView;
@class YQHChatMessageModel;

@interface YQHBaseMessageCell : UITableViewCell
{
    UIButton *_statusButton;
    UILabel *_hasRead;
    YQHBubbleView *_bubbleView;
    UIActivityIndicatorView *_activity;
    NSLayoutConstraint *_statusWidthConstraint;
}

@property (weak, nonatomic) id<YQHMessageCellDelegate> delegate;

@property (nonatomic, strong) UIActivityIndicatorView *activity;

@property (strong, nonatomic) UIImageView *avatarView1;

@property (strong, nonatomic) UIButton *statusButton;

@property (strong, nonatomic) UILabel *hasRead;

@property (strong, nonatomic) YQHBubbleView *bubbleView;

@property (strong, nonatomic) YQHChatMessageModel* model;

@property (nonatomic) CGFloat statusSize UI_APPEARANCE_SELECTOR; //default 20;

@property (nonatomic) CGFloat activitySize UI_APPEARANCE_SELECTOR; //default 20;

@property (nonatomic) CGFloat bubbleMaxWidth UI_APPEARANCE_SELECTOR; //default 200;

@property (nonatomic) UIEdgeInsets bubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 0, 8, 0);

@property (nonatomic) UIEdgeInsets leftBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 15, 8, 10);

@property (nonatomic) UIEdgeInsets rightBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 10, 8, 15);

@property (strong, nonatomic) UIImage *sendBubbleBackgroundImage UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic) UIImage *recvBubbleBackgroundImage UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIFont *messageTextFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:15];

@property (nonatomic) UIColor *messageTextColor UI_APPEARANCE_SELECTOR; //default [UIColor blackColor];

@property (nonatomic) UIFont *messageLocationFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:12];

@property (nonatomic) UIColor *messageLocationColor UI_APPEARANCE_SELECTOR; //default [UIColor whiteColor];

@property (nonatomic) NSArray *sendMessageVoiceAnimationImages UI_APPEARANCE_SELECTOR;

@property (nonatomic) NSArray *recvMessageVoiceAnimationImages UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *messageVoiceDurationColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor];

@property (nonatomic) UIFont *messageVoiceDurationFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:12];

@property (nonatomic) UIFont *messageFileNameFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:13];

@property (nonatomic) UIColor *messageFileNameColor UI_APPEARANCE_SELECTOR; //default [UIColor blackColor];

@property (nonatomic) UIFont *messageFileSizeFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:11];

@property (nonatomic) UIColor *messageFileSizeColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor];

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(YQHChatMessageModel*)model;

+ (NSString *)cellIdentifierWithModel:(YQHChatMessageModel*)model;

+ (CGFloat)cellHeightWithModel:(YQHChatMessageModel*)model;

@end

//@protocol YQHMessageCellDelegate <NSObject>
//
//@optional
//
//- (void)messageCellSelected:(YQHChatMessageModel*)model;
//
//- (void)statusButtonSelcted:(YQHChatMessageModel*)model withMessageCell:(YQHBaseMessageCell*)messageCell;
//
//- (void)avatarViewSelcted:(YQHChatMessageModel*)model;
//
//@end
