//
//  YQHChatDefine.h
//  Pods
//
//  Created by 杨棋贺 on 2019/5/16.
//

#ifndef YQHChatDefine_h
#define YQHChatDefine_h

#import "HQIBUtilities.h"

/*!
 *  会话类型
 */
typedef enum {
    YQHSingleChatType  = 0,    //单聊会话
    YQHGroupChatType = 1,    //群聊会话
    YQHRoomChatType = 2      //聊天室会话
} YQHChatType;

/*!
 *  消息发送状态
 */
typedef enum {
    YQHMessageStatusPending  = 0,    /*! \~chinese 发送未开始 \~english Pending */
    YQHMessageStatusDelivering=1,      /*! \~chinese 正在发送 \~english Delivering */
    YQHMessageStatusSucceed=2,       /*! \~chinese 发送成功 \~english Succeed */
    YQHMessageStatusFailed=3,          /*! \~chinese 发送失败 \~english Failed */
} YQHChatMessageStatus;

/*!
 *  消息方向
 */
typedef enum {
    YQHMessageDirectionSend = 0,    /*! \~chinese 发送的消息 \~english Send */
    YQHMessageDirectionReceive=1,     /*! \~chinese 接收的消息 \~english Receive */
} YQHChatMessageDirection;


/*!
 *  消息消息类型
 */
typedef enum {
    YQHChatMessageTextType   = 1,    /*! \~chinese 文本类型 \~english Text */
    YQHChatMessageImageType=2,         /*! \~chinese 图片类型 \~english Image */
    YQHChatMessageVideoType=3,         /*! \~chinese 视频类型 \~english Video */
    YQHChatMessageLocationType=4,      /*! \~chinese 位置类型 \~english Location */
    YQHChatMessageVoiceType=5,         /*! \~chinese 语音类型 \~english Voice */
    YQHChatMessageFileType=6,          /*! \~chinese 文件类型 \~english File */
    YQHChatMessageCmdType=7,           /*! \~chinese 命令类型 \~english Command */
} YQHChatMessageType;


#define WidthScale [UIScreen mainScreen].bounds.size.width / 375

#define SCREEN_WIDTH         [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT        [[UIScreen mainScreen] bounds].size.height

#define YQHMessageCellPadding 10

//#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)


//#define HQ_IS_IPHONEX  [HQIBUtilities isIphoneX]

#define HQ_IS_IPHONEX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define SafeAreaBottomHeight ((HQ_IS_IPHONEX == YES) ? 34 : 0)
/// 导航栏宏
#define SafeAreaTopHeight ((HQ_IS_IPHONEX == YES) ? 88 : 64)

#define iPhoneX_BOTTOM_HEIGHT  ([UIScreen mainScreen].bounds.size.height==812?34:0)

#define kEMMessageImageSizeWidth 120
#define kEMMessageImageSizeHeight 120
#define kEMMessageLocationHeight 95
#define kEMMessageVoiceHeight 30


#define ChatMessageImageWidth 120
#define ChatMessageImageHeight 120

//图片最大尺寸和最小尺寸
#define ChatMessageImageMaxWidth    160
#define ChatMessageImageMinWidth     50

#define ChatMessageImageMinHeight    50
#define ChatMessageImageMaxHeight    160

//教师标志
#define chatTeacherAvatarImageBg [UIImage imageNamed:@"image_top_teacher"]
//聊天界面头像背景
#define chatMessageAvatarImageBg [UIImage imageNamed:@"icon_user_parents_def"]
//聊天界面消息发送失败提示图标
#define chatMessageSendFail [UIImage imageNamed:@"chat_message_send_faild"]
//聊天界面下载图片背景
#define chatMessageImageBg [UIImage imageNamed:@"icon_photo_bg"]
//聊天界面视频背景
#define chatMessageVedioBg [UIImage imageNamed:@"chat_video_play"]
//聊天界面接受者语音背景
#define chatMessageAudioReceiverBg [UIImage imageNamed:@"chat_receiver_audio_playing_full"]
//聊天界面发送者语音背景
#define chatMessageAudioSenderBg [UIImage imageNamed:@"chat_sender_audio_playing_full"]

//群组头像 没有人的时候
#define chatMessageGroupUnknow [UIImage imageNamed:@"chat_group_unknow"]



#define chatFileXsl [UIImage imageNamed:@"chat_file_xsl"]
#define chatFilePdf [UIImage imageNamed:@"chat_file_pdf"]
#define chatFilePpt [UIImage imageNamed:@"chat_file_ppt"]
#define chatFileWord [UIImage imageNamed:@"chat_file_word"]
#define chatFileUnknow [UIImage imageNamed:@"chat_file_unknow"]

#define chatAvatarImageSize 45

#define newFriendMsgConversation @"newFriendMsgConversation"


#endif /* YQHChatDefine_h */
