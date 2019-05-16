//
//  YQHMessageCell.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHBaseMessageCell.h"

#import "YQHBubbleView+Text.h"
#import "YQHBubbleView+Image.h"
#import "YQHBubbleView+Voice.h"
#import "YQHBubbleView+Video.h"
#import "YQHChatMessageModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const YQHMessageCellIdentifierRecvText = @"YQHMessageCellRecvText";
NSString *const YQHMessageCellIdentifierRecvVoice = @"YQHMessageCellRecvVoice";
NSString *const YQHMessageCellIdentifierRecvVideo = @"YQHMessageCellRecvVideo";
NSString *const YQHMessageCellIdentifierRecvImage = @"YQHMessageCellRecvImage";

NSString *const YQHMessageCellIdentifierSendText = @"YQHMessageCellSendText";
NSString *const YQHMessageCellIdentifierSendVoice = @"YQHMessageCellSendVoice";
NSString *const YQHMessageCellIdentifierSendVideo = @"YQHMessageCellSendVideo";
NSString *const YQHMessageCellIdentifierSendImage = @"YQHMessageCellSendImage";

@interface YQHBaseMessageCell()
{
    YQHChatMessageType _messageType;
}

@property (nonatomic) NSLayoutConstraint *statusWidthConstraint;
@property (nonatomic) NSLayoutConstraint *activtiyWidthConstraint;
@property (nonatomic) NSLayoutConstraint *hasReadWidthConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleMaxWidthConstraint;

@end


@implementation YQHBaseMessageCell


@synthesize statusButton = _statusButton;
@synthesize bubbleView = _bubbleView;
@synthesize hasRead = _hasRead;
@synthesize activity = _activity;

+ (void)initialize
{
    YQHBaseMessageCell *cell = [self appearance];
    cell.statusSize = 20;
    cell.activitySize = 20;
    cell.bubbleMaxWidth = 249;//文字宽度
    cell.leftBubbleMargin = UIEdgeInsetsMake(8, 15, 8, 10);
    cell.rightBubbleMargin = UIEdgeInsetsMake(8, 10, 8, 15);
    cell.bubbleMargin = UIEdgeInsetsMake(8, 0, 8, 0);
    
    cell.messageTextFont = [UIFont systemFontOfSize:15];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(YQHChatMessageModel*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageType = model.chatMessageType;
        [self _setupSubviewsWithType:_messageType isSender:model.isSender model:model];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - setup subviews

- (void)_setupSubviewsWithType:(YQHChatMessageType)messageType isSender:(BOOL)isSender model:(YQHChatMessageModel*)model
{
    
    _statusButton = [[UIButton alloc] init];
    _statusButton.translatesAutoresizingMaskIntoConstraints = NO;
    _statusButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_statusButton setImage:chatMessageSendFail forState:UIControlStateNormal];
    [_statusButton addTarget:self action:@selector(statusAction) forControlEvents:UIControlEventTouchUpInside];
    _statusButton.hidden = YES;
    [self.contentView addSubview:_statusButton];
    
    _bubbleView = [[YQHBubbleView alloc] initWithMargin:isSender?_rightBubbleMargin:_leftBubbleMargin isSender:isSender];
    _bubbleView.translatesAutoresizingMaskIntoConstraints = NO;
    _bubbleView.textLabel.font = _messageTextFont;
    [self.contentView addSubview:_bubbleView];
    if (isSender) {
        _bubbleView.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];//RGB(51, 51, 51);
    }else{
        _bubbleView.textLabel.textColor = [UIColor whiteColor];
    }
    
    _avatarView1 = [[UIImageView alloc] init];
    _avatarView1.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarView1.backgroundColor = [UIColor clearColor];
    _avatarView1.clipsToBounds = YES;
    _avatarView1.userInteractionEnabled = YES;
    [self.contentView addSubview:_avatarView1];
    
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activity.translatesAutoresizingMaskIntoConstraints = NO;
    _activity.backgroundColor = [UIColor clearColor];
    _activity.hidden = YES;
    [self.contentView addSubview:_activity];
    
        
        switch (messageType) {
            case YQHChatMessageTextType:
            {
                [_bubbleView setupTextBubbleView];
            }
                break;
            case YQHChatMessageImageType:
            {
                [_bubbleView setupImageBubbleView];
            }
                break;
            case YQHChatMessageVoiceType:
            {
                [_bubbleView setupVoiceBubbleView];
                _bubbleView.voiceDurationLabel.textColor = _messageVoiceDurationColor;
                _bubbleView.voiceDurationLabel.font = _messageVoiceDurationFont;
            }
                break;
            case YQHChatMessageVideoType:
            {
                [_bubbleView setupVideoBubbleView];
                _bubbleView.videoTagView.image = chatMessageVedioBg;
            }
                break;
            default:
                break;
        }
    
    [self _setupConstraints];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewTapAction:)];
    [_bubbleView addGestureRecognizer:tapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarViewTapAction:)];
    [_avatarView1 addGestureRecognizer:tapRecognizer2];
}

#pragma mark - Setup Constraints

- (void)_setupConstraints
{
    //bubble view
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];
    
    //status button
    self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.statusSize];
    [self addConstraint:self.statusWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.statusButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    //activtiy
    self.activtiyWidthConstraint = [NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.activitySize];
    [self addConstraint:self.activtiyWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.activity attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self _updateHasReadWidthConstraint];
    
    if (self.hasRead) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.statusButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.activity attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    }
}

#pragma mark - Update Constraint

- (void)_updateHasReadWidthConstraint
{
    if (_hasRead) {
        [self removeConstraint:self.hasReadWidthConstraint];
        
        self.hasReadWidthConstraint = [NSLayoutConstraint constraintWithItem:_hasRead attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:40];
        [self addConstraint:self.hasReadWidthConstraint];
    }
}

- (void)_updateStatusButtonWidthConstraint
{
    if (_statusButton) {
        [self removeConstraint:self.statusWidthConstraint];
        
        self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.statusSize];
        [self addConstraint:self.statusWidthConstraint];
    }
}

- (void)_updateActivityWidthConstraint
{
    if (_activity) {
        [self removeConstraint:self.activtiyWidthConstraint];
        
        self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.activitySize];
        [self addConstraint:self.activtiyWidthConstraint];
    }
}

- (void)_updateBubbleMaxWidthConstraint
{
    [self removeConstraint:self.bubbleMaxWidthConstraint];
    
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];
}

#pragma mark - setter

- (void)setModel:(YQHChatMessageModel*)model
{
    _model = model;
        switch (model.chatMessageType) {
            case YQHChatMessageTextType:
            {
                if(model.attributedText){
                    _bubbleView.textLabel.attributedText = model.attributedText;
                }
            }
                break;
            case YQHChatMessageImageType:
            {
                UIImage *image = _model.thumbnailImage;
                if (!image) {
                    image = _model.image;
                    if (!image) {
                        if (model.fileLocalPath||model.fileThumbnailLocalPath){//图片或者缩略图本地地址存在  优先显示缩略图
                            NSString *lcalPath=[model.fileThumbnailLocalPath length]?model.fileThumbnailLocalPath:model.fileLocalPath;
                            NSURL *localURL = [NSURL fileURLWithPath:lcalPath];
                            [_bubbleView.imageView sd_setImageWithURL:localURL placeholderImage:chatMessageImageBg options:SDWebImageRefreshCached];
                        }else{
                            [_bubbleView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.fileURLPath] placeholderImage:chatMessageImageBg];
                        }
                        
                    } else {
                        _bubbleView.imageView.image = image;
                    }
                } else {
                    _bubbleView.imageView.image = image;
                }
            }
                break;
            case YQHChatMessageVoiceType:
            {
                if (_bubbleView.voiceImageView) {
                    if ([self.sendMessageVoiceAnimationImages count] > 0 && [self.recvMessageVoiceAnimationImages count] > 0) {
                        self.bubbleView.voiceImageView.image = self.model.isSender ?[self.sendMessageVoiceAnimationImages objectAtIndex:0] : [self.recvMessageVoiceAnimationImages objectAtIndex:0];
                        _bubbleView.voiceImageView.animationImages = self.model.isSender ? self.sendMessageVoiceAnimationImages:self.recvMessageVoiceAnimationImages;
                    } else {
                        self.bubbleView.voiceImageView.image = self.model.isSender ?chatMessageAudioReceiverBg:chatMessageAudioSenderBg;
                    }
                }
                if (!self.model.isSender) {
                    if (self.model.isMediaPlayed){
                        _bubbleView.isReadView.hidden = YES;
                    } else {
                        _bubbleView.isReadView.hidden = NO;
                    }
                }else{
                    _bubbleView.voiceDurationLabel.textColor=[UIColor whiteColor];
                }
                
                if (_model.isMediaPlaying) {
                    [_bubbleView.voiceImageView startAnimating];
                }
                else{
                    [_bubbleView.voiceImageView stopAnimating];
                }
                
                _bubbleView.voiceDurationLabel.text = [NSString stringWithFormat:@"%d''",(int)_model.mediaDuration];
            }
                break;
            case YQHChatMessageVideoType:
            {
                UIImage *image = _model.isSender ? _model.image : _model.thumbnailImage;
                if (!image) {
                    image = _model.image;
                    if (!image) {
                        [_bubbleView.videoImageView sd_setImageWithURL:[NSURL URLWithString:_model.fileURLPath] placeholderImage:chatMessageImageBg];
                    } else {
                        _bubbleView.videoImageView.image = image;
                    }
                } else {
                    //[_bubbleView.videoImageView sd_setImageWithURL:[NSURL URLWithString:_model.thumbnailRemotePath] placeholderImage:chatMessageVedioBg];
                    _bubbleView.videoImageView.image=image;
                }
            }
                break;
            default:
                break;
        }
}

- (void)setStatusSize:(CGFloat)statusSize
{
    _statusSize = statusSize;
    [self _updateStatusButtonWidthConstraint];
}

- (void)setActivitySize:(CGFloat)activitySize
{
    _activitySize = activitySize;
    [self _updateActivityWidthConstraint];
}

- (void)setSendBubbleBackgroundImage:(UIImage *)sendBubbleBackgroundImage
{
    _sendBubbleBackgroundImage = sendBubbleBackgroundImage;
}

- (void)setRecvBubbleBackgroundImage:(UIImage *)recvBubbleBackgroundImage
{
    _recvBubbleBackgroundImage = recvBubbleBackgroundImage;
}

- (void)setBubbleMaxWidth:(CGFloat)bubbleMaxWidth
{
    _bubbleMaxWidth = bubbleMaxWidth;
    [self _updateBubbleMaxWidthConstraint];
}

- (void)setRightBubbleMargin:(UIEdgeInsets)rightBubbleMargin
{
    _rightBubbleMargin = rightBubbleMargin;
}

- (void)setLeftBubbleMargin:(UIEdgeInsets)leftBubbleMargin
{
    _leftBubbleMargin = leftBubbleMargin;
}

//设置margin 暂时去除
- (void)setBubbleMargin:(UIEdgeInsets)bubbleMargin
{
    _bubbleMargin = bubbleMargin;
    _bubbleMargin = self.model.isSender ? _rightBubbleMargin:_leftBubbleMargin;
        if (_bubbleView) {
            switch (_messageType) {
                case YQHChatMessageTextType:
                {
                    [_bubbleView updateTextMargin:_bubbleMargin];
                }
                    break;
                case YQHChatMessageImageType:
                {
                    [_bubbleView updateImageMargin:_bubbleMargin];
                }
                    break;
                case YQHChatMessageVoiceType:
                {
                    [_bubbleView updateVoiceMargin:_bubbleMargin];
                }
                    break;
                case YQHChatMessageVideoType:
                {
                    [_bubbleView updateVideoMargin:_bubbleMargin];
                }
                    break;
                default:
                    break;
            }

        }
}

- (void)setMessageTextFont:(UIFont *)messageTextFont
{
    _messageTextFont = messageTextFont;
    if (_bubbleView.textLabel) {
        _bubbleView.textLabel.font = messageTextFont;
    }
}

- (void)setMessageTextColor:(UIColor *)messageTextColor
{
    _messageTextColor = messageTextColor;
    if (_bubbleView.textLabel) {
        _bubbleView.textLabel.textColor = _messageTextColor;
    }
}

- (void)setMessageLocationColor:(UIColor *)messageLocationColor
{
    _messageLocationColor = messageLocationColor;
    if (_bubbleView.locationLabel) {
        _bubbleView.locationLabel.textColor = _messageLocationColor;
    }
}

- (void)setMessageLocationFont:(UIFont *)messageLocationFont
{
    _messageLocationFont = messageLocationFont;
    if (_bubbleView.locationLabel) {
        _bubbleView.locationLabel.font = _messageLocationFont;
    }
}

- (void)setSendMessageVoiceAnimationImages:(NSArray *)sendMessageVoiceAnimationImages
{
    _sendMessageVoiceAnimationImages = sendMessageVoiceAnimationImages;
}

- (void)setRecvMessageVoiceAnimationImages:(NSArray *)recvMessageVoiceAnimationImages
{
    _recvMessageVoiceAnimationImages = recvMessageVoiceAnimationImages;
}

- (void)setMessageVoiceDurationColor:(UIColor *)messageVoiceDurationColor
{
    _messageVoiceDurationColor = messageVoiceDurationColor;
    if (_bubbleView.voiceDurationLabel) {
        _bubbleView.voiceDurationLabel.textColor = _messageVoiceDurationColor;
    }
}

- (void)setMessageVoiceDurationFont:(UIFont *)messageVoiceDurationFont
{
    _messageVoiceDurationFont = messageVoiceDurationFont;
    if (_bubbleView.voiceDurationLabel) {
        _bubbleView.voiceDurationLabel.font = _messageVoiceDurationFont;
    }
}

- (void)setMessageFileNameFont:(UIFont *)messageFileNameFont
{
    _messageFileNameFont = messageFileNameFont;
    if (_bubbleView.fileNameLabel) {
        _bubbleView.fileNameLabel.font = _messageFileNameFont;
    }
}

- (void)setMessageFileNameColor:(UIColor *)messageFileNameColor
{
    _messageFileNameColor = messageFileNameColor;
    if (_bubbleView.fileNameLabel) {
        _bubbleView.fileNameLabel.textColor = _messageFileNameColor;
    }
}

- (void)setMessageFileSizeFont:(UIFont *)messageFileSizeFont
{
    _messageFileSizeFont = messageFileSizeFont;
    if (_bubbleView.fileSizeLabel) {
        _bubbleView.fileSizeLabel.font = _messageFileSizeFont;
    }
}

- (void)setMessageFileSizeColor:(UIColor *)messageFileSizeColor
{
    _messageFileSizeColor = messageFileSizeColor;
    if (_bubbleView.fileSizeLabel) {
        _bubbleView.fileSizeLabel.textColor = _messageFileSizeColor;
    }
}

#pragma mark - action

- (void)bubbleViewTapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        if (!_delegate) {
            return;
        }
        
        switch (_model.chatMessageType) {
            case YQHChatMessageImageType:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:withMessageCell:)]) {
                    [_delegate messageCellSelected:_model withMessageCell:self];
                }
            }
                break;
            case YQHChatMessageVoiceType:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:withMessageCell:)]) {
                    [_delegate messageCellSelected:_model withMessageCell:self];
                }
            }
                break;
            case YQHChatMessageVideoType:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:withMessageCell:)]) {
                    [_delegate messageCellSelected:_model withMessageCell:self];
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)avatarViewTapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if ([_delegate respondsToSelector:@selector(avatarViewSelcted:)]) {
        [_delegate avatarViewSelcted:_model];
    }
}

- (void)statusAction
{
    if ([_delegate respondsToSelector:@selector(statusButtonSelcted:withMessageCell:)]) {
        [_delegate statusButtonSelcted:_model withMessageCell:self];
    }
}


#pragma mark - public
+ (NSString *)cellIdentifierWithModel:(YQHChatMessageModel*)model
{
    NSString *cellIdentifier = nil;
    if (model.isSender) {
        switch (model.chatMessageType) {
            case YQHChatMessageTextType:
                cellIdentifier = YQHMessageCellIdentifierSendText;
                break;
            case YQHChatMessageImageType:
                cellIdentifier = YQHMessageCellIdentifierSendImage;
                break;
            case YQHChatMessageVideoType:
                cellIdentifier = YQHMessageCellIdentifierSendVideo;
                break;
            case YQHChatMessageVoiceType:
                cellIdentifier = YQHMessageCellIdentifierSendVoice;
                break;
            default:
                break;
        }
    }
    else{
        switch (model.chatMessageType) {
            case YQHChatMessageTextType:
                cellIdentifier = YQHMessageCellIdentifierRecvText;
                break;
            case YQHChatMessageImageType:
                cellIdentifier = YQHMessageCellIdentifierRecvImage;
                break;
            case YQHChatMessageVideoType:
                cellIdentifier = YQHMessageCellIdentifierRecvVideo;
                break;
            case YQHChatMessageVoiceType:
                cellIdentifier = YQHMessageCellIdentifierRecvVoice;
                break;
            default:
                break;
        }
    }
    
    return cellIdentifier;
}

+ (CGFloat)cellHeightWithModel:(YQHChatMessageModel*)model
{
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    YQHBaseMessageCell *cell = [self appearance];
    CGFloat bubbleMaxWidth = cell.bubbleMaxWidth;
    
    
    bubbleMaxWidth -= (cell.leftBubbleMargin.left + cell.leftBubbleMargin.right + cell.rightBubbleMargin.left + cell.rightBubbleMargin.right)/2;
    
    CGFloat height = 10;//EaseMessageCellPadding + cell.bubbleMargin.top + cell.bubbleMargin.bottom;
    
    switch (model.chatMessageType) {
        case YQHChatMessageTextType:
        {
            if (model.attributedText) {
                NSAttributedString *text = model.attributedText;
                CGRect rect = [text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
                height += (rect.size.height > 20 ? rect.size.height : 20) + 10;
            }
            if (model.chatType==YQHGroupChatType) {
                height +=15;
            }else{
                height +=0;
            }
        }
            break;
        case YQHChatMessageImageType:
        {
            //图片和视频一样
        }
        case YQHChatMessageVideoType:
        {
            CGSize retSize = model.fileThumbnailSize;
            if (retSize.width == 0 || retSize.height == 0) {
                retSize.width = kEMMessageImageSizeWidth;
                retSize.height = kEMMessageImageSizeHeight;
            }
            else if (retSize.width > retSize.height) {
                CGFloat height =  kEMMessageImageSizeWidth / retSize.width * retSize.height;
                retSize.height = height;
                retSize.width = kEMMessageImageSizeWidth;
            }
            else {
                CGFloat width = kEMMessageImageSizeHeight / retSize.height * retSize.width;
                retSize.width = width;
                retSize.height = kEMMessageImageSizeHeight;
            }
            
            height += retSize.height;
        }
            break;
        case YQHChatMessageVoiceType:
        {
            height += kEMMessageVoiceHeight;
        }
            break;
        default:
            break;
    }
    
    model.cellHeight = height;
    
    return height;
}



//计算文字的大小
+ (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //计算文本的大小
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return nameSize;
}



@end
