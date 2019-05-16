//
//  YQHChatMessageVideoCell.h
//  AliyunOSSiOS
//
//  Created by 杨棋贺 on 2019/5/8.
//

#import <UIKit/UIKit.h>
#import "YQHBubbleView+Image.h"
#import "YQHChatMessageDelegate.h"

@class YQHChatMessageModel;

@interface YQHChatMessageVideoCell : UITableViewCell

@property (strong, nonatomic) UIImage *sendBubbleBackgroundImage;

@property (strong, nonatomic) UIImage *recvBubbleBackgroundImage;

@property (strong, nonatomic) UIImageView *avatarView;

@property (strong, nonatomic) YQHBubbleView *bubbleView;


@property (strong, nonatomic) YQHChatMessageModel* model;

@property (weak, nonatomic) id<YQHMessageCellDelegate> delegate;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(YQHChatMessageModel*)model;

+ (CGFloat)cellHeightWithModel:(YQHChatMessageModel*)model;

@end

