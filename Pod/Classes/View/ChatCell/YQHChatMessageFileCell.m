//
//  YQHChatMessageFileCell.m
//  AFNetworking
//
//  Created by 杨棋贺 on 2019/6/27.
//

#import "YQHChatMessageFileCell.h"
#import "YQHChatMessageModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YQHChatMessageFileCell()

@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (strong, nonatomic) UIButton *statusButton;
@property (strong, nonatomic) UILabel *hasRead;

@property (nonatomic) CGFloat bubbleMaxWidth;
@property (nonatomic) UIEdgeInsets bubbleMargin;
@property (nonatomic) UIEdgeInsets leftBubbleMargin;
@property (nonatomic) UIEdgeInsets rightBubbleMargin;

@property (nonatomic) CGFloat avatarSize;
@property (nonatomic) CGFloat statusSize;
@property (nonatomic) CGFloat activitySize;

@property (nonatomic) NSLayoutConstraint *avatarWidthConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleMaxWidthConstraint;
@property (nonatomic) NSLayoutConstraint *activtiyWidthConstraint;
@property (nonatomic) NSLayoutConstraint *statusWidthConstraint;
@property (nonatomic) NSLayoutConstraint *hasReadWidthConstraint;

@end

@implementation YQHChatMessageFileCell

//#define chatSendBubbleBg [[UIImage imageNamed:@"chat_sender_bubble"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]

//#define chatReceiverBubbleBg [[UIImage imageNamed:@"chat_receiver_bubble"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]

static const CGFloat cellMargin=15;

+ (void)initialize
{
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(YQHChatMessageModel*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _avatarSize=chatAvatarImageSize;
        _statusSize = 20;
        _activitySize = 20;
        _bubbleMaxWidth = 200;
        _leftBubbleMargin = UIEdgeInsetsMake(8, 15, 8, 10);
        _rightBubbleMargin = UIEdgeInsetsMake(8, 10, 8, 15);
        _bubbleMargin = UIEdgeInsetsMake(8, 0, 8, 0);
        //[self setSendBubbleBackgroundImage:chatSendBubbleBg];
        //[self setRecvBubbleBackgroundImage:chatReceiverBubbleBg];
        [self _setupSubviewsWithType:model.chatMessageType isSender:model.isSender model:model];
    }
    return self;
}

//长按图标 显示菜单
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - setup subviews

- (void)_setupSubviewsWithType:(YQHChatMessageType)messageType isSender:(BOOL)isSender model:(YQHChatMessageModel*)model
{
    _avatarView = [HQChatAvatarView new];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarView.backgroundColor = [UIColor clearColor];
    _avatarView.clipsToBounds = YES;
    _avatarView.userInteractionEnabled = YES;
    [self.contentView addSubview:_avatarView];
    
    //_avatarView.layer.cornerRadius=25;
    
    //群聊显示姓名  单聊不显示姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:10];
    //_nameLabel.textColor = _messageNameColor;
    [self.contentView addSubview:_nameLabel];
    
    
    _bubbleView = [[YQHBubbleView alloc] initWithMargin:isSender?_rightBubbleMargin:_leftBubbleMargin isSender:isSender];
    [self.contentView addSubview:_bubbleView];
    _bubbleView.backgroundColor=[UIColor clearColor];
    //_bubbleView.backgroundColor=[UIColor grayColor];
    _bubbleView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_bubbleView setupFileBubbleView];
    
    
    if (isSender) {
        _bubbleView.fileNameLabel.textColor = [UIColor whiteColor];
        _bubbleView.fileSizeLabel.textColor = [UIColor whiteColor];
        
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.translatesAutoresizingMaskIntoConstraints = NO;
        _activity.backgroundColor = [UIColor clearColor];
        _activity.hidden = YES;
        [_activity startAnimating];
        [self.contentView addSubview:_activity];
        
        _statusButton = [[UIButton alloc] init];
        _statusButton.translatesAutoresizingMaskIntoConstraints = NO;
        _statusButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_statusButton setImage:chatMessageSendFail forState:UIControlStateNormal];
        [_statusButton addTarget:self action:@selector(statusAction) forControlEvents:UIControlEventTouchUpInside];
        _statusButton.hidden = YES;
        [self.contentView addSubview:_statusButton];
        
        _hasRead = [[UILabel alloc] init];
        _hasRead.translatesAutoresizingMaskIntoConstraints = NO;
        _hasRead.text = @"已读";
        _hasRead.textAlignment = NSTextAlignmentCenter;
        _hasRead.font = [UIFont systemFontOfSize:12];
        _hasRead.hidden = YES;
        _hasRead.backgroundColor=[UIColor clearColor];
        [_hasRead sizeToFit];
        [self.contentView addSubview:_hasRead];
        
        [self configureSendLayoutConstraints];
        
    }else{
        _bubbleView.fileNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _bubbleView.fileSizeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
        
        [self configureRecvLayoutConstraints];
    }
    
    
    
    
    if (model.isSender) {
        
    } else {
        
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewTapAction:)];
    [_bubbleView addGestureRecognizer:tapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarViewTapAction:)];
    [_avatarView addGestureRecognizer:tapRecognizer2];
}

#pragma mark - Setup Constraints

- (void)configureSendLayoutConstraints
{
    //头像
    self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize];
    [self addConstraint:self.avatarWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:cellMargin]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-YQHMessageCellPadding]];
    
    //姓名
    //if (self.isShowName) {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5]];
    //}
    
    //气泡 NSLayoutRelationLessThanOrEqual
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:cellMargin]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-cellMargin]];
    
    
    //进度条
    self.activtiyWidthConstraint = [NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.activitySize];
    [self addConstraint:self.activtiyWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.activity attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    //状态
    self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.statusSize];
    [self addConstraint:self.statusWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.statusButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    //是否已读
    self.hasReadWidthConstraint = [NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.00 constant:40];
    
    [self addConstraint:self.hasReadWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.hasRead attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)configureRecvLayoutConstraints
{
    //头像
    self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize];
    [self addConstraint:self.avatarWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:cellMargin]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:YQHMessageCellPadding]];
    
    //姓名
    //if (self.isShowName) {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:YQHMessageCellPadding]];
    //}
    
    
    //气泡   NSLayoutRelationLessThanOrEqual
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:cellMargin]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-cellMargin]];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
}


#pragma mark - Update Constraint
- (void)setAvatarSize:(CGFloat)avatarSize
{
    _avatarSize = avatarSize;
    if (self.avatarView) {
        [self removeConstraint:self.avatarWidthConstraint];
        self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.avatarSize];
        [self addConstraint:self.avatarWidthConstraint];
    }
}

- (void)updateBubbleMaxWidthConstraint
{
    [self removeConstraint:self.bubbleMaxWidthConstraint];
    
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];
}

- (void)updateActivityWidthConstraint
{
    if (_activity) {
        [self removeConstraint:self.activtiyWidthConstraint];
        
        self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.activitySize];
        [self addConstraint:self.activtiyWidthConstraint];
    }
}

- (void)updateStatusButtonWidthConstraint
{
    if (_statusButton) {
        [self removeConstraint:self.statusWidthConstraint];
        
        self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.statusSize];
        [self addConstraint:self.statusWidthConstraint];
    }
}

- (void)updateHasReadWidthConstraint
{
    if (_hasRead) {
        [self removeConstraint:self.hasReadWidthConstraint];
        
        self.hasReadWidthConstraint = [NSLayoutConstraint constraintWithItem:_hasRead attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:40];
        [self addConstraint:self.hasReadWidthConstraint];
    }
}


#pragma mark - setter

- (void)setModel:(YQHChatMessageModel*)model
{
    _model = model;
    
    _nameLabel.text=_model.nickname;
    
    NSString *extension=[model.fileLocalPath pathExtension];
    
    if ([extension containsString:@"xls"]) {
        _bubbleView.fileIconView.image = chatFileXsl;
    }else if ([extension containsString:@"pdf"]){
        _bubbleView.fileIconView.image = chatFilePdf;
    }else if ([extension containsString:@"ppt"]){
        _bubbleView.fileIconView.image = chatFilePpt;
    }else if ([extension containsString:@"doc"]){
        _bubbleView.fileIconView.image = chatFileWord;
    }else{
        _bubbleView.fileIconView.image = chatFileUnknow;
    }
    
    _bubbleView.fileNameLabel.text = _model.fileName;
    
    if (_model.fileLengthDes) {
        _bubbleView.fileSizeLabel.text = _model.fileLengthDes;//[NSString stringWithFormat:@"%lld",_model.fileLength];
    }else{
        _bubbleView.fileSizeLabel.text = @"0 B";
    }
    
    
    if (self.isShowName) {
        _nameLabel.hidden=NO;
    }else{
        _nameLabel.hidden=YES;
    }
    
    self.bubbleMaxWidth=model.cellBubbleWidth;
    
    if (self.model.isSender) {
        _hasRead.hidden = YES;
        switch (self.model.status) {
            case YQHMessageStatusDelivering:
            {
                _statusButton.hidden = YES;
                [_activity setHidden:NO];
                [_activity startAnimating];
            }
                break;
            case YQHMessageStatusSucceed:
            {
                _statusButton.hidden = YES;
                [_activity stopAnimating];
                if (self.model.isRead) {
                    _hasRead.hidden = NO;
                }
            }
                break;
            case YQHMessageStatusPending:
                _statusButton.hidden = YES;
                [_activity setHidden:NO];
                [_activity startAnimating];
                
//                [_activity stopAnimating];
//                [_activity setHidden:YES];
//                _statusButton.hidden = NO;
                
                break;
            case YQHMessageStatusFailed:
            {
                [_activity stopAnimating];
                [_activity setHidden:YES];
                _statusButton.hidden = NO;
            }
                break;
            default:
                break;
        }
    }
}


- (void)setStatusSize:(CGFloat)statusSize
{
    _statusSize = statusSize;
    [self updateStatusButtonWidthConstraint];
}

- (void)setActivitySize:(CGFloat)activitySize
{
    _activitySize = activitySize;
    [self updateActivityWidthConstraint];
}

- (void)setBubbleMaxWidth:(CGFloat)bubbleMaxWidth
{
    _bubbleMaxWidth = bubbleMaxWidth;
    [self updateBubbleMaxWidthConstraint];
}


- (void)setSendBubbleBackgroundImage:(UIImage *)sendBubbleBackgroundImage
{
    _sendBubbleBackgroundImage = sendBubbleBackgroundImage;
}

- (void)setRecvBubbleBackgroundImage:(UIImage *)recvBubbleBackgroundImage
{
    _recvBubbleBackgroundImage = recvBubbleBackgroundImage;
}

- (void)setRightBubbleMargin:(UIEdgeInsets)rightBubbleMargin
{
    _rightBubbleMargin = rightBubbleMargin;
}

- (void)setLeftBubbleMargin:(UIEdgeInsets)leftBubbleMargin
{
    _leftBubbleMargin = leftBubbleMargin;
}

- (void)setBubbleMargin:(UIEdgeInsets)bubbleMargin
{
    _bubbleMargin = bubbleMargin;
    _bubbleMargin = self.model.isSender ? _rightBubbleMargin:_leftBubbleMargin;
    if (_bubbleView) {
        [_bubbleView updateFileMargin:_bubbleMargin];
    }
}


#pragma mark - action

- (void)bubbleViewTapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_delegate&&[_delegate respondsToSelector:@selector(messageCellSelected:withMessageCell:)]) {
            [_delegate messageCellSelected:_model withMessageCell:self];
        }
    }
}

- (void)avatarViewTapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if (_delegate&&[_delegate respondsToSelector:@selector(avatarViewSelcted:)]) {
        [_delegate avatarViewSelcted:_model];
    }
}

- (void)statusAction
{
    if (_delegate&&[_delegate respondsToSelector:@selector(statusButtonSelcted:withMessageCell:)]) {
        [_delegate statusButtonSelcted:_model withMessageCell:self];
    }
}


#pragma mark - public

+ (CGFloat)cellHeightWithModel:(YQHChatMessageModel*)model
{
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    model.cellHeight = 100*WidthScale;
    
    model.cellBubbleHeight=100*WidthScale;
    
    model.cellBubbleWidth=240;
    
    return model.cellHeight;
}

@end
