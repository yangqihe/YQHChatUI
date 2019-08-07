//
//  YQHChatMessageFileCell.h
//  AFNetworking
//
//  Created by 杨棋贺 on 2019/6/27.
//

#import <UIKit/UIKit.h>

#import "YQHBubbleView+File.h"
#import "YQHChatMessageDelegate.h"
#import "HQChatAvatarView.h"

@class YQHChatMessageModel;

@interface YQHChatMessageFileCell : UITableViewCell

@property (nonatomic) BOOL isShowName;//是否展示姓名

@property (strong, nonatomic) UIImage *sendBubbleBackgroundImage;

@property (strong, nonatomic) UIImage *recvBubbleBackgroundImage;

@property (strong, nonatomic) HQChatAvatarView *avatarView;

@property (strong, nonatomic) YQHBubbleView *bubbleView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) YQHChatMessageModel* model;

@property (weak, nonatomic) id<YQHMessageCellDelegate> delegate;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(YQHChatMessageModel*)model;

+ (CGFloat)cellHeightWithModel:(YQHChatMessageModel*)model;

@end


