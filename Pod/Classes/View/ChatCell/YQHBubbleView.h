//
//  YQHBubbleView.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YQHMessageCellPadding 10

extern NSString *const YQHMessageCellIdentifierSendText;
extern NSString *const YQHMessageCellIdentifierSendVoice;
extern NSString *const YQHMessageCellIdentifierSendVideo;
extern NSString *const YQHMessageCellIdentifierSendImage;

extern NSString *const YQHMessageCellIdentifierRecvText;
extern NSString *const YQHMessageCellIdentifierRecvVoice;
extern NSString *const YQHMessageCellIdentifierRecvVideo;
extern NSString *const YQHMessageCellIdentifierRecvImage;

@interface YQHBubbleView : UIView
{
    UIEdgeInsets _margin;
    CGFloat _fileIconSize;
}

@property (nonatomic) BOOL isSender;

@property (nonatomic, readonly) UIEdgeInsets margin;

@property (strong, nonatomic) NSMutableArray *marginConstraints;

@property (strong, nonatomic) UIImageView *backgroundImageView;

//text views
@property (strong, nonatomic) UILabel *textLabel;

//image views
@property (strong, nonatomic) UIImageView *imageView;

//location views
@property (strong, nonatomic) UIImageView *locationImageView;
@property (strong, nonatomic) UILabel *locationLabel;

//voice views
@property (strong, nonatomic) UIImageView *voiceImageView;
@property (strong, nonatomic) UILabel *voiceDurationLabel;
@property (strong, nonatomic) UIImageView *isReadView;

//video views
@property (strong, nonatomic) UIImageView *videoImageView;
@property (strong, nonatomic) UIImageView *videoTagView;

//file views
@property (strong, nonatomic) UIImageView *fileIconView;
@property (strong, nonatomic) UILabel *fileNameLabel;
@property (strong, nonatomic) UILabel *fileSizeLabel;

- (instancetype)initWithMargin:(UIEdgeInsets)margin isSender:(BOOL)isSender;


@end

