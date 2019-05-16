////
////  YQHCustomMessageCell.m
////  家校共享
////
////  Created by 杨棋贺 on 2019/2/28.
////  Copyright © 2019年 mac. All rights reserved.
////
//
//#import "YQHCustomMessageCell.h"
//
//#import "YQHBubbleView+Gif.h"
//#import "UIImage+GIF.h"
//#import "IMessageModel.h"
//
//@interface YQHCustomMessageCell()
//
//@end
//
//@implementation YQHCustomMessageCell
//
//+ (void)initialize
//{
//    // UIAppearance Proxy Defaults
//}
//
//#pragma mark - IModelCell
//
//- (BOOL)isCustomBubbleView:(id<IMessageModel>)model
//{
//    return YES;
//}
//
//- (void)setCustomModel:(id<IMessageModel>)model
//{
//    UIImage *image = model.image;
//    if (!image) {
//        [self.bubbleView.imageView sd_setImageWithURL:[NSURL URLWithString:model.fileURLPath] placeholderImage:[UIImage imageNamed:model.failImageName]];
//    } else {
//        _bubbleView.imageView.image = image;
//    }
//
//    if (model.avatarURLPath) {
//        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath] placeholderImage:model.avatarImage];
//    } else {
//        self.avatarView.image = model.avatarImage;
//    }
//}
//
//- (void)setCustomBubbleView:(id<IMessageModel>)model
//{
//    [_bubbleView setupGifBubbleView];
//
//    _bubbleView.imageView.image = [UIImage imageNamed:@"imageDownloadFail"];
//}
//
//- (void)updateCustomBubbleViewMargin:(UIEdgeInsets)bubbleMargin model:(id<IMessageModel>)model
//{
//    [_bubbleView updateGifMargin:bubbleMargin];
//}
//
//+ (NSString *)cellIdentifierWithModel:(id<IMessageModel>)model
//{
//    return model.isSender?@"YQHMessageCellSendGif":@"YQHMessageCellRecvGif";
//}
//
//+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
//{
//    return 100;
//}
//
//
//@end
