//
//  YQHChatMessageModel.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import "chatConst.h"

/**
 消息
 */

@interface YQHChatMessageModel : NSObject

/*!
 *  消息的唯一标识符
 */
@property (nonatomic, copy) NSString *messageId;

/*!
 *  本地消息ID
 */
@property (nonatomic, copy) NSString *localMessageId;

/*!
 *  所属会话的唯一标识符
 */
@property (nonatomic, copy) NSString *conversationId;

/*!
 *  消息的方向
 */
@property (nonatomic) YQHChatMessageDirection direction;

/*!
 *  是否是发送者
 */
@property (nonatomic) BOOL isSender;

/**
 发送者昵称
 */
@property (nonatomic, copy) NSString* nickname;


/**
 发送者头像URL
 */
@property (nonatomic, copy) NSString* avatarURL;

/**
 发送者头像本地路径
 */
@property (nonatomic, copy) NSString *avatarLocalPath;


/*!
 *  文件URL路径
 */
@property (strong, nonatomic) NSString *fileURLPath;

/*!
 *  文件本地路径
 */
@property (strong, nonatomic) NSString *fileLocalPath;

/*!
 *  缩略文件URL路径
 */
@property (strong, nonatomic) NSString *fileThumbnailURLPath;

/*!
 *  缩略文件本地路径
 */
@property (strong, nonatomic) NSString *fileThumbnailLocalPath;

/**
 文件大小
 */
@property (nonatomic) CGSize fileSize;

/**
 缩略文件大小
 */
@property (nonatomic) CGSize fileThumbnailSize;


/**
 文件的扩展
 */
@property (strong, nonatomic) NSString *fileExt;


/*!
 *  发送方
 */
@property (nonatomic, copy) NSString *from;

/*!
 *  接收方
 */
@property (nonatomic, copy) NSString *to;

/*!
 *  发送方 标识
 */
@property (nonatomic, copy) NSString *fromAppKey;

/*!
 *  接收方 标识
 */
@property (nonatomic, copy) NSString *targetAppKey;

/*!
 *  时间戳，服务器收到此消息的时间
 */
@property (nonatomic) long long timestamp;

/*!
 *  客户端发送/收到此消息的时间
 */
@property (nonatomic) long long localTime;

/*!
 *  聊天类型
 */
@property (nonatomic) YQHChatType chatType;

/*!
 *  消息状态
 */
@property (nonatomic) YQHChatMessageStatus status;



/*!
 *  是否已读
 */
@property (nonatomic) BOOL isRead;

/*!
 *  消息 类型
 */
@property (nonatomic) YQHChatMessageType chatMessageType;

/*!
 *  消息扩展
 *
 *  Key值类型必须是NSString, Value值类型必须是NSString或者 NSNumber类型的 BOOL, int, unsigned in, long long, double.
 */
@property (nonatomic, copy) NSDictionary *ext;



/*!
 *  文本内容   文本消息
 */
@property (nonatomic, copy) NSString *text;

/**
 需要表情映射
 */
@property (nonatomic, copy)NSAttributedString *attributedText;



/**
 图片      图片消息   视频消息
 */
@property (strong, nonatomic) UIImage *image;

/**
 缩略图
 */
@property (strong, nonatomic) UIImage *thumbnailImage;



/**
 文件是否正在播放中    声音消息
 */
@property (nonatomic) BOOL isMediaPlaying;

/**
 文件是否已经播放
 */
@property (nonatomic) BOOL isMediaPlayed;

/**
 文件的播放时间
 */
@property (nonatomic) CGFloat mediaDuration;



/**
 地址     地理位置消息
 */
@property (strong, nonatomic) NSString *address;

/**
 纬度
 */
@property (nonatomic) double latitude;

/**
 经度
 */
@property (nonatomic) double longitude;






/**
 动态计算cell的高度  计算过的保留下来避免重新计算
 */
@property (nonatomic) CGFloat cellHeight;

/**
 动态计算bubbleView宽度
 */
@property (nonatomic) CGFloat cellBubbleWidth;

/**
 动态计算bubbleView高度
 */
@property (nonatomic) CGFloat cellBubbleHeight;


/*!
 *  \~chinese
 *  附件的密钥, 下载附件时需要密匙做校验
 */
@property (nonatomic, copy) NSString *secretKey;








/*!
 *  图片附件的尺寸
 */
//@property (nonatomic) CGSize size;

/*!
 *  SDK会根据压缩率compressRatio來发送消息
 *  设置发送图片消息时的压缩率。1.0表示发送原图不压缩。默认值是0.6，压缩的倍数是0.6倍。如果设置了小于等于0的值，则使用默认值
 */
//@property (nonatomic) CGFloat compressionRatio;


/*!
 *  缩略图的显示名
 */
//@property (nonatomic, copy) NSString *thumbnailDisplayName;

/*!
 *  缩略图的本地路径
 *  UIImage *image = [UIImage imageWithContentsOfFile:thumbnailLocalPath];
 */
//@property (nonatomic, copy) NSString *thumbnailLocalPath;

/*!
 *  缩略图在服务器的路径
 */
//@property (nonatomic, copy) NSString *thumbnailRemotePath;

/*!
 *  缩略图的密钥, 下载缩略图时需要密匙做校验
 */
//@property (nonatomic, copy) NSString *thumbnailSecretKey;

/*!
 *  缩略图的尺寸
 */
//@property (nonatomic) CGSize thumbnailSize;

/*!
 *  缩略图文件的大小, 以字节为单位
 */
//@property (nonatomic) long long thumbnailFileLength;

/**
 文件的图标      文件消息
 */
//@property (strong, nonatomic) NSString *fileIconName;

/**
 文件的名称
 */
//@property (strong, nonatomic) NSString *fileName;

/**
 文件的大小描述
 */
//@property (strong, nonatomic) NSString *fileSizeDes;


/*!
 *  已读回执是否已发送/收到, 对于发送方表示是否已经收到已读回执，对于接收方表示是否已经发送已读回执
 */
//@property (nonatomic) BOOL isReadAcked;

/*!
 *送达回执是否已发送/收到，对于发送方表示是否已经收到送达回执，对于接收方表示是否已经发送送达回执，如果EMOptions设置了enableDeliveryAck，SDK收到消息后会自动发送送达回执
 */
//@property (nonatomic) BOOL isDeliverAcked;


/**
 图片数据  暂时保留 后期去掉
 */
@property (strong, nonatomic) NSData *imageData;

/**
 图片尺寸
 */
//@property (nonatomic) CGSize imageSize;

/**
 缩略图尺寸
 */
//@property (nonatomic) CGSize thumbnailImageSize;


/**
 发送者头像  影响性能
 */
//@property (nonatomic, copy) UIImage* avatarImage;


@end
