//
//  YQHChatMessageImageCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQHBubbleView+Image.h"
#import "YQHBubbleView+Video.h"
#import "YQHChatMessageDelegate.h"

@class YQHChatMessageModel;

@interface YQHChatMessageImageCell : UITableViewCell

@property (nonatomic) BOOL isShowName;//是否展示姓名

@property (strong, nonatomic) UIImage *sendBubbleBackgroundImage;

@property (strong, nonatomic) UIImage *recvBubbleBackgroundImage;

@property (strong, nonatomic) UIImageView *avatarView;

@property (strong, nonatomic) YQHBubbleView *bubbleView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) YQHChatMessageModel* model;

@property (weak, nonatomic) id<YQHMessageCellDelegate> delegate;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(YQHChatMessageModel*)model;

+ (CGFloat)cellHeightWithModel:(YQHChatMessageModel*)model;


@end

