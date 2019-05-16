//
//  YQHChatMessageModel.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatMessageModel.h"
#import "YQHEmotionEscape.h"
#import "YQHConvertToCommonEmoticonsHelper.h"
//#import "YQHChatContactTool.h"
//#import "YQHChatContactModel.h"

@implementation YQHChatMessageModel

//-(void)setMessage:(EMMessage*)message{
//    _message=message;
//    //消息ID
//    _messageId=message.messageId;
//    //会话ID
//    _conversationId=message.conversationId;
//
//    if (message.direction==EMMessageDirectionSend) {
//        _direction=YQHMessageDirectionSend;
//    }else{
//        _direction=YQHMessageDirectionReceive;
//    }
//    //发送方
//    _from=message.from;
//    //接收方
//    _to=message.to;
//
//    //时间戳，服务器收到此消息的时间
//    _timestamp=message.timestamp;
//
//    //客户端发送/收到此消息的时间
//    _localTime=message.localTime;
//
//    //消息类型
//    if(message.chatType==EMChatTypeChat){
//        _chatType=YQHSingleChatType;
//    }else if(message.chatType==EMChatTypeGroupChat){
//        _chatType=YQHGroupChatType;
//    }else if(message.chatType==EMChatTypeChatRoom){
//        _chatType=YQHRoomChatType;
//    }
//
//    if (message.body.type==EMMessageBodyTypeText) {
//        _chatMessageType=YQHChatMessageTextType;
//        //_text=((EMTextMessageBody *)message.body).text;
//        _text=[self getContentFromMessage:message];
//        if (_text) {
//            _attributedText= [[YQHEmotionEscape sharedInstance] attStringFromTextForChatting:_text textFont:[UIFont systemFontOfSize:15]];
//        }
//    }else if (message.body.type==EMMessageBodyTypeImage){
//        _chatMessageType=YQHChatMessageImageType;
//        EMImageMessageBody *imgMessageBody = (EMImageMessageBody *)message.body;
//        NSData *imageData = [NSData dataWithContentsOfFile:imgMessageBody.localPath];
//        if (imageData.length) {
//            self.image = [UIImage imageWithData:imageData];
//        }
//
//        if ([imgMessageBody.thumbnailLocalPath length] > 0) {
//            self.thumbnailImage = [UIImage imageWithContentsOfFile:imgMessageBody.thumbnailLocalPath];
//        }
//        else{
//            CGSize size = self.image.size;
//            self.thumbnailImage = size.width * size.height > 200 * 200 ? [self scaleImage:self.image toScale:sqrt((200 * 200) / (size.width * size.height))] : self.image;
//        }
//
//        self.thumbnailImageSize = self.thumbnailImage.size;
//        self.imageSize = imgMessageBody.size;
//
//        if (!_isSender) {
//            self.fileURLPath = imgMessageBody.remotePath;
//        }
//    }else if (message.body.type==EMMessageBodyTypeVoice){
//        _chatMessageType=YQHChatMessageVoiceType;
//        EMVoiceMessageBody *voiceBody = (EMVoiceMessageBody *)message.body;
//        self.mediaDuration = voiceBody.duration;
//        self.isMediaPlayed = NO;
//        if (message.ext) {
//            self.isMediaPlayed = [[message.ext objectForKey:@"isPlayed"] boolValue];
//        }
//        self.fileURLPath = voiceBody.remotePath;
//        _fileLocalPath=voiceBody.localPath;
//    }else if (message.body.type==EMMessageBodyTypeVideo){
//        _chatMessageType=YQHChatMessageVideoType;
//        _chatMessageType=YQHChatMessageVideoType;
//        EMVideoMessageBody *videoBody = (EMVideoMessageBody *)message.body;
//        self.thumbnailImageSize = videoBody.thumbnailSize;
//        if ([videoBody.thumbnailLocalPath length] > 0) {
//            NSData *thumbnailImageData = [NSData dataWithContentsOfFile:videoBody.thumbnailLocalPath];
//            if (thumbnailImageData.length) {
//                self.thumbnailImage = [UIImage imageWithData:thumbnailImageData];
//            }
//            self.image = self.thumbnailImage;
//        }
//        self.fileURLPath = videoBody.remotePath;
//    }
//
//    //消息状态
//    if (message.status==EMMessageStatusPending) {
//        _status=YQHMessageStatusPending;//发送未开始
//    }else if (message.status==EMMessageStatusDelivering){
//        _status=YQHMessageStatusDelivering;//正在发送
//    }else if (message.status==EMMessageStatusSucceed){
//        _status=YQHMessageStatusSucceed;//发送成功
//    }else if (message.status==EMMessageStatusFailed){
//        _status=YQHMessageStatusFailed;//发送失败
//    }
//
//    //已读回执是否已发送/收到, 对于发送方表示是否已经收到已读回执，对于接收方表示是否已经发送已读回执
//    _isReadAcked=message.isReadAcked;
//
//    //送达回执是否已发送/收到，对于发送方表示是否已经收到送达回执，对于接收方表示是否已经发送送达回执，如果EMOptions设置了enableDeliveryAck，SDK收到消息后会自动发送送达回执
//    _isDeliverAcked=message.isDeliverAcked;
//
//    //是否已读
//    _isRead=message.isRead;
//
//    //消息体
//    //_body=message.body;
//
//    //消息扩展
//    _ext=message.ext;
//
//    //是否时是发送者
//    _isSender = message.direction == EMMessageDirectionSend ? YES : NO;
//
//    _isMediaPlaying = NO;
//
//    //获取头像的URL 和昵称
//    YQHChatContactModel* contact=[[YQHChatContactTool shareInstance] getContactModel:_from];
//    if (contact) {
//        _avatarURL=contact.imageUrl;
//        _nickname=contact.userName;
//    }
//}

//- (NSString*)getContentFromMessage:(EMMessage*)message
//{
//    NSString *content = @"";
//    if (message) {
//        EMMessageBody *messageBody = message.body;
//        switch (messageBody.type) {
//            case EMMessageBodyTypeImage:{
//                content = NSLocalizedString(@"message.image1", @"[image]");
//            } break;
//            case EMMessageBodyTypeText:{
//                // 表情映射。
//                NSString *didReceiveText = [YQHConvertToCommonEmoticonsHelper
//                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
//                content = didReceiveText;
//                if ([message.ext objectForKey:@"em_is_big_expression"]) {
//                    content = @"[动画表情]";
//                }
//            } break;
//            case EMMessageBodyTypeVoice:{
//                content = @"[语音]";//NSLocalizedString(@"message.voice1", @"[voice]");
//            } break;
//            case EMMessageBodyTypeLocation: {
//                content = @"[位置]";//NSLocalizedString(@"message.location1", @"[location]");
//            } break;
//            case EMMessageBodyTypeVideo: {
//                content = @"[视频]";//NSLocalizedString(@"message.video1", @"[video]");
//            } break;
//            case EMMessageBodyTypeFile: {
//                content = @"[文件]";//NSLocalizedString(@"message.file1", @"[file]");
//            } break;
//            default: {
//            } break;
//        }
//    }
//    return content;
//}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
