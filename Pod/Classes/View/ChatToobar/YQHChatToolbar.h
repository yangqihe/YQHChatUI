//
//  YQHChatToolbar.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQHChatBarMoreView.h"
#import "YQHFaceView.h"
#import "YQHTextView.h"
#import "YQHRecordView.h"
#import "YQHChatToolbarItem.h"

@protocol YQHChatToolbarDelegate;

@interface YQHChatToolbar : UIView

@property (weak, nonatomic) id<YQHChatToolbarDelegate> delegate;

@property (nonatomic) UIImage *backgroundImage;

@property (nonatomic, readonly) YQHChatToolbarType chatBarType;

@property (nonatomic, readonly) CGFloat inputViewMaxHeight;

@property (nonatomic, readonly) CGFloat inputViewMinHeight;

@property (nonatomic, readonly) CGFloat horizontalPadding;

@property (nonatomic, readonly) CGFloat verticalPadding;

@property (strong, nonatomic) NSArray *inputViewLeftItems;

@property (strong, nonatomic) NSArray *inputViewRightItems;

@property (strong, nonatomic) YQHTextView *inputTextView;

@property (strong, nonatomic) UIView *moreView;

@property (strong, nonatomic) UIView *faceView;

@property (strong, nonatomic) UIView *recordView;

- (instancetype)initWithFrame:(CGRect)frame
type:(YQHChatToolbarType)type;

/**
 *  Initializa chat bar
 * @param horizontalPadding  default 8
 * @param verticalPadding    default 5
 * @param inputViewMinHeight default 36
 * @param inputViewMaxHeight default 150
 * @param type               default EMChatToolbarTypeGroup
 */
//- (instancetype)initWithFrame:(CGRect)frame
//            horizontalPadding:(CGFloat)horizontalPadding
//              verticalPadding:(CGFloat)verticalPadding
//           inputViewMinHeight:(CGFloat)inputViewMinHeight
//           inputViewMaxHeight:(CGFloat)inputViewMaxHeight
//                         type:(YQHChatToolbarType)type;

+ (CGFloat)defaultHeight;

- (void)cancelTouchRecord;

- (void)willShowBottomView:(UIView *)bottomView;

@end

@protocol YQHChatToolbarDelegate <NSObject>

@optional

- (void)inputTextViewDidBeginEditing:(YQHTextView *)inputTextView;

- (void)inputTextViewWillBeginEditing:(YQHTextView *)inputTextView;

- (void)didSendText:(NSString *)text;

- (void)didSendText:(NSString *)text withExt:(NSDictionary*)ext;

- (BOOL)didInputAtInLocation:(NSUInteger)location;

- (BOOL)didDeleteCharacterFromLocation:(NSUInteger)location;

- (void)didSendFace:(NSString *)faceLocalPath;

- (void)didStartRecordingVoiceAction:(UIView *)recordView;

- (void)didCancelRecordingVoiceAction:(UIView *)recordView;

- (void)didFinishRecoingVoiceAction:(UIView *)recordView;

- (void)didDragOutsideAction:(UIView *)recordView;

- (void)didDragInsideAction:(UIView *)recordView;

@required

- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight;

@end
