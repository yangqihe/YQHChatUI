//
//  YQHChatToolbar.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "YQHChatToolbar.h"

#import "YQHEmotionEscape.h"
#import "YQHEmotionManager.h"
#import "YQHEmoji.h"
#import "chatConst.h"

//水平间距
const CGFloat horizontalPadding=8.0f;
//垂直间距
const CGFloat verticalPadding=10.0f;
//输入框高度
const CGFloat inputViewMinHeight=35.0f;
//最大输入高度
const CGFloat inputViewMaxHeight=150.0f;

@interface YQHChatToolbar()<UITextViewDelegate, YQHFaceDelegate>

@property (nonatomic) CGFloat version;
@property (strong, nonatomic) NSMutableArray *leftItems;
@property (strong, nonatomic) NSMutableArray *rightItems;
@property (strong, nonatomic) UIImageView *toolbarBackgroundImageView;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) BOOL isShowButtomView;
@property (strong, nonatomic) UIView *activityButtomView;
@property (strong, nonatomic) UIView *toolbarView;
@property (strong, nonatomic) UIButton *recordButton;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIButton *faceButton;
@property (nonatomic) CGFloat previousTextViewContentHeight;//上一次inputTextView的contentSize.height
@property (nonatomic) NSLayoutConstraint *inputViewWidthItemsLeftConstraint;
@property (nonatomic) NSLayoutConstraint *inputViewWidthoutItemsLeftConstraint;

@end

@implementation YQHChatToolbar

@synthesize faceView = _faceView;
@synthesize moreView = _moreView;
@synthesize recordView = _recordView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame type:YQHChatToolbarTypeGroup];
    if (self) {
        
    }
    
    return self;
}


+ (CGFloat)defaultHeight
{
    return verticalPadding * 2 + inputViewMinHeight;
}

- (instancetype)initWithFrame:(CGRect)frame type:(YQHChatToolbarType)type
{
    frame.size.height=verticalPadding * 2 + inputViewMinHeight;
    self = [super initWithFrame:frame];
    if (self) {
        _horizontalPadding = horizontalPadding;
        _verticalPadding = verticalPadding;
        _inputViewMinHeight = inputViewMinHeight;
        _inputViewMaxHeight = inputViewMaxHeight;
        _chatBarType = type;
        
        _leftItems = [NSMutableArray array];
        _rightItems = [NSMutableArray array];
        _version = [[[UIDevice currentDevice] systemVersion] floatValue];
        _activityButtomView = nil;
        _isShowButtomView = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [self _setupSubviews];
    }
    return self;
}

#pragma mark - setup subviews

- (void)_setupSubviews
{
    //toolbar
    _toolbarView = [[UIView alloc] initWithFrame:self.bounds];
    _toolbarView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_toolbarView];
    
    //input textview
    _inputTextView = [[YQHTextView alloc] initWithFrame:CGRectMake(self.horizontalPadding, self.verticalPadding, self.frame.size.width - self.verticalPadding * 2, self.frame.size.height - self.verticalPadding * 2)];
    _inputTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inputTextView.scrollEnabled = YES;
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
    _inputTextView.backgroundColor = [UIColor colorWithRed:244/255.0 green:246/255.0 blue:249/255.0 alpha:1.0];
    _inputTextView.delegate = self;
    //_inputTextView.backgroundColor = [UIColor clearColor];
    //_inputTextView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    //_inputTextView.layer.borderWidth = 0.65f;
    _inputTextView.layer.cornerRadius = 17.5f;
    _previousTextViewContentHeight = [self _getTextViewContentH:_inputTextView];
    [_toolbarView addSubview:_inputTextView];
    
    //change input type
    UIButton *styleChangeButton = [[UIButton alloc] init];
    styleChangeButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [styleChangeButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [styleChangeButton setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [styleChangeButton addTarget:self action:@selector(styleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    YQHChatToolbarItem *styleItem = [[YQHChatToolbarItem alloc] initWithButton:styleChangeButton withView:nil];
    [self setInputViewLeftItems:@[styleItem]];
    
    //record
    self.recordButton = [[UIButton alloc] initWithFrame:self.inputTextView.frame];
    self.recordButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.recordButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.recordButton setBackgroundImage:[[UIImage imageNamed:@"chatBar_recordBg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [self.recordButton setBackgroundImage:[[UIImage imageNamed:@"chatBar_recordSelectedBg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    [self.recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.recordButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    self.recordButton.hidden = YES;
    [self.recordButton addTarget:self action:@selector(recordButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.recordButton addTarget:self action:@selector(recordButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self.recordButton addTarget:self action:@selector(recordButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.recordButton addTarget:self action:@selector(recordDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [self.recordButton addTarget:self action:@selector(recordDragInside) forControlEvents:UIControlEventTouchDragEnter];
    self.recordButton.hidden = YES;
    [self.recordButton.layer setMasksToBounds:YES];
    self.recordButton.layer.cornerRadius = 17.5f;
    [self.toolbarView addSubview:self.recordButton];
    
    //emoji
    self.faceButton = [[UIButton alloc] init];
    self.faceButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.faceButton setImage:[UIImage imageNamed:@"expression"] forState:UIControlStateNormal];
    [self.faceButton setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [self.faceButton addTarget:self action:@selector(faceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    YQHChatToolbarItem *faceItem = [[YQHChatToolbarItem alloc] initWithButton:self.faceButton withView:self.faceView];
    
    //more
    self.moreButton = [[UIButton alloc] init];
    self.moreButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.moreButton setImage:[UIImage imageNamed:@"Add_to"] forState:UIControlStateNormal];
    [self.moreButton setImage:[UIImage imageNamed:@"Add_to"] forState:UIControlStateSelected];
    [self.moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    YQHChatToolbarItem *moreItem = [[YQHChatToolbarItem alloc] initWithButton:self.moreButton withView:self.moreView];
    
    [self setInputViewRightItems:@[faceItem, moreItem]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _delegate = nil;
    _inputTextView.delegate = nil;
    _inputTextView = nil;
}

#pragma mark - getter

- (UIView *)recordView
{
    if (_recordView == nil) {
        _recordView = [[YQHRecordView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    }
    
    return _recordView;
}

- (UIView *)faceView
{
    if (_faceView == nil) {
        _faceView = [[YQHFaceView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_toolbarView.frame), self.frame.size.width, 180)];
        [(YQHFaceView *)_faceView setDelegate:self];
        _faceView.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:247/255.0 alpha:1.0];//RGB(240, 242, 247);//[UIColor colorWithRed:240 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0];
        _faceView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _faceView;
}

- (UIView *)moreView
{
    if (_moreView == nil) {
        _moreView = [[YQHChatBarMoreView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_toolbarView.frame), self.frame.size.width, 80) type:self.chatBarType];
        _moreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _moreView;
}

#pragma mark - setter

- (void)setDelegate:(id)delegate
{
    _delegate = delegate;
    if ([_moreView isKindOfClass:[YQHChatBarMoreView class]]) {
        [(YQHChatBarMoreView *)_moreView setDelegate:delegate];
    }
}

- (void)setRecordView:(UIView *)recordView
{
    if(_recordView != recordView){
        _recordView = recordView;
    }
}

- (void)setMoreView:(UIView *)moreView
{
    if (_moreView != moreView) {
        _moreView = moreView;
        
        for (YQHChatToolbarItem *item in self.rightItems) {
            if (item.button == self.moreButton) {
                item.button2View = _moreView;
                break;
            }
        }
    }
}

- (void)setFaceView:(UIView *)faceView
{
    if (_faceView != faceView) {
        _faceView = faceView;
        
        for (YQHChatToolbarItem *item in self.rightItems) {
            if (item.button == self.faceButton) {
                item.button2View = _faceView;
                break;
            }
        }
    }
}

- (NSArray*)inputViewLeftItems
{
    return self.leftItems;
}

- (void)setInputViewLeftItems:(NSArray *)inputViewLeftItems
{
    for (YQHChatToolbarItem *item in self.leftItems) {
        [item.button removeFromSuperview];
        [item.button2View removeFromSuperview];
    }
    [self.leftItems removeAllObjects];
    
    CGFloat oX = self.horizontalPadding;
    CGFloat itemHeight = self.toolbarView.frame.size.height - self.verticalPadding * 2;
    for (id item in inputViewLeftItems) {
        if ([item isKindOfClass:[YQHChatToolbarItem class]]) {
            YQHChatToolbarItem *chatItem = (YQHChatToolbarItem *)item;
            if (chatItem.button) {
                CGRect itemFrame = chatItem.button.frame;
                if (itemFrame.size.height == 0) {
                    itemFrame.size.height = itemHeight;
                }
                
                if (itemFrame.size.width == 0) {
                    itemFrame.size.width = itemFrame.size.height;
                }
                
                itemFrame.origin.x = oX;
                itemFrame.origin.y = (self.toolbarView.frame.size.height - itemFrame.size.height) / 2;
                chatItem.button.frame = itemFrame;
                oX += (itemFrame.size.width + self.horizontalPadding);
                
                [self.toolbarView addSubview:chatItem.button];
                [self.leftItems addObject:chatItem];
            }
        }
    }
    
    CGRect inputFrame = self.inputTextView.frame;
    CGFloat value = inputFrame.origin.x - oX;
    inputFrame.origin.x = oX;
    inputFrame.size.width += value;
    self.inputTextView.frame = inputFrame;
    
    CGRect recordFrame = self.recordButton.frame;
    recordFrame.origin.x = inputFrame.origin.x;
    recordFrame.size.width = inputFrame.size.width;
    self.recordButton.frame = recordFrame;
}

- (NSArray*)inputViewRightItems
{
    return self.rightItems;
}

- (void)setInputViewRightItems:(NSArray *)inputViewRightItems
{
    for (YQHChatToolbarItem *item in self.rightItems) {
        [item.button removeFromSuperview];
        [item.button2View removeFromSuperview];
    }
    [self.rightItems removeAllObjects];
    
    CGFloat oMaxX = self.toolbarView.frame.size.width-15;// - self.horizontalPadding;
    CGFloat itemHeight = self.toolbarView.frame.size.height - self.verticalPadding * 2;
    if ([inputViewRightItems count] > 0) {
        for (NSInteger i = (inputViewRightItems.count - 1); i >= 0; i--) {
            id item = [inputViewRightItems objectAtIndex:i];
            if ([item isKindOfClass:[YQHChatToolbarItem class]]) {
                YQHChatToolbarItem *chatItem = (YQHChatToolbarItem *)item;
                if (chatItem.button) {
                    CGRect itemFrame = chatItem.button.frame;
                    if (itemFrame.size.height == 0) {
                        itemFrame.size.height = itemHeight;
                    }
                    
                    if (itemFrame.size.width == 0) {
                        itemFrame.size.width = itemFrame.size.height;
                    }
                    
                    oMaxX -= itemFrame.size.width;
                    itemFrame.origin.x = oMaxX;
                    itemFrame.origin.y = (self.toolbarView.frame.size.height - itemFrame.size.height) / 2;
                    chatItem.button.frame = itemFrame;
                    oMaxX -= self.horizontalPadding;
                    
                    [self.toolbarView addSubview:chatItem.button];
                    [self.rightItems addObject:item];
                }
            }
        }
    }
    
    CGRect inputFrame = self.inputTextView.frame;
    CGFloat value = oMaxX - CGRectGetMaxX(inputFrame);
    inputFrame.size.width += value;
    self.inputTextView.frame = inputFrame;
    
    CGRect recordFrame = self.recordButton.frame;
    recordFrame.origin.x = inputFrame.origin.x;
    recordFrame.size.width = inputFrame.size.width;
    self.recordButton.frame = recordFrame;
}

#pragma mark - private input view

- (CGFloat)_getTextViewContentH:(UITextView *)textView
{
    if (self.version >= 7.0)
    {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

- (void)_willShowInputTextViewToHeight:(CGFloat)toHeight
{
    //self.inputTextView.scrollEnabled = false;
    //[self.inputTextView scrollRangeToVisible:self.inputTextView.selectedRange];
    if (toHeight < self.inputViewMinHeight) {
        toHeight = self.inputViewMinHeight;
    }
    if (toHeight > self.inputViewMaxHeight) {
        toHeight = self.inputViewMaxHeight;
    }
    
    if (toHeight == _previousTextViewContentHeight)
    {
        //[self.inputTextView setScrollsToTop:YES];
        return;
    }
    else{
        CGFloat changeHeight = toHeight - _previousTextViewContentHeight;
        
        CGRect rect = self.frame;
        rect.size.height += changeHeight;
        rect.origin.y -= changeHeight;
        self.frame = rect;
        
        rect = self.toolbarView.frame;
        rect.size.height += changeHeight;
        self.toolbarView.frame = rect;
        
        if (self.version < 7.0) {
            [self.inputTextView setContentOffset:CGPointMake(0.0f, (self.inputTextView.contentSize.height - self.inputTextView.frame.size.height) / 2) animated:YES];
        }
        _previousTextViewContentHeight = toHeight;
        
        if (_delegate && [_delegate respondsToSelector:@selector(chatToolbarDidChangeFrameToHeight:)]) {
            [_delegate chatToolbarDidChangeFrameToHeight:self.frame.size.height];
        }
    }
}

#pragma mark - private bottom view

- (void)_willShowBottomHeight:(CGFloat)bottomHeight
{
    CGRect fromFrame = self.frame;
    CGFloat toHeight = self.toolbarView.frame.size.height + bottomHeight;
    
    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
    
    if(bottomHeight == 0 && self.frame.size.height == self.toolbarView.frame.size.height)
    {
        return;
    }
    
    if (bottomHeight == 0) {
        self.isShowButtomView = NO;
    }
    else{
        self.isShowButtomView = YES;
    }
    
//    [UIView animateWithDuration:0.5 animations:^{
        self.frame = toFrame;
//    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(chatToolbarDidChangeFrameToHeight:)]) {
        [_delegate chatToolbarDidChangeFrameToHeight:toHeight];
    }
}

- (void)_willShowBottomView:(UIView *)bottomView
{
    if (![self.activityButtomView isEqual:bottomView]) {
        CGFloat bottomHeight = bottomView ? bottomView.frame.size.height : 0;
        [self _willShowBottomHeight:bottomHeight];
        
        if (bottomView) {
            CGRect rect = bottomView.frame;
            rect.origin.y = CGRectGetMaxY(self.toolbarView.frame);
            bottomView.frame = rect;
            [self addSubview:bottomView];
        }
        
        if (self.activityButtomView) {
            [self.activityButtomView removeFromSuperview];
        }
        self.activityButtomView = bottomView;
    }
}

- (void)_willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
//    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
//    {
//        [self _willShowBottomHeight:toFrame.size.height];
//        if (self.activityButtomView) {
//            [self.activityButtomView removeFromSuperview];
//        }
//        self.activityButtomView = nil;
//    }
//    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
//    {
//        [self _willShowBottomHeight:0];
//    }
//    else{
//        [self _willShowBottomHeight:toFrame.size.height];
//    }
    
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        [self _willShowBottomHeight:toFrame.size.height - iPhoneX_BOTTOM_HEIGHT];
        if (self.activityButtomView) {
            [self.activityButtomView removeFromSuperview];
        }
        self.activityButtomView = nil;
    }
    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        [self _willShowBottomHeight:0];
    }
    else{
        [self _willShowBottomHeight:toFrame.size.height - iPhoneX_BOTTOM_HEIGHT];
    }
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)]) {
        [self.delegate inputTextViewWillBeginEditing:self.inputTextView];
    }
    
    for (YQHChatToolbarItem *item in self.leftItems) {
        item.button.selected = NO;
    }
    
    for (YQHChatToolbarItem *item in self.rightItems) {
        item.button.selected = NO;
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.inputTextView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
            [self.delegate didSendText:textView.text];
            self.inputTextView.text = @"";
            [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];
        }
        
        return NO;
    }
    else if ([text isEqualToString:@"@"]) {
        if ([self.delegate respondsToSelector:@selector(didInputAtInLocation:)]) {
            if ([self.delegate didInputAtInLocation:range.location]) {
                [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];
                return NO;
            }
        }
    }
    else if ([text length] == 0) {
        //delete one character
        if (range.length == 1 && [self.delegate respondsToSelector:@selector(didDeleteCharacterFromLocation:)]) {
            return ![self.delegate didDeleteCharacterFromLocation:range.location];
        }
    }
    //[self.inputTextView scrollRangeToVisible:self.inputTextView.selectedRange];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self _willShowInputTextViewToHeight:[self _getTextViewContentH:textView]];
    //[self.inputTextView scrollRangeToVisible:self.inputTextView.selectedRange];
}

#pragma mark - DXFaceDelegate

- (void)selectedFacialView:(NSString *)str isDelete:(BOOL)isDelete
{
    NSString *chatText = self.inputTextView.text;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputTextView.attributedText];
    
    if (!isDelete && str.length > 0) {
        if (self.version >= 7.0) {
            NSRange range = [self.inputTextView selectedRange];
            [attr insertAttributedString:[[YQHEmotionEscape sharedInstance] attStringFromTextForInputView:str textFont:self.inputTextView.font] atIndex:range.location];
            self.inputTextView.attributedText = attr;
        } else {
            self.inputTextView.text = @"";
            self.inputTextView.text = [NSString stringWithFormat:@"%@%@",chatText,str];
        }
    }
    else {
        if (self.version >= 7.0) {
            if (chatText.length > 0) {
                NSInteger length = 1;
                if (chatText.length >= 2) {
                    NSString *subStr = [chatText substringFromIndex:chatText.length-2];
                    if ([YQHEmoji stringContainsEmoji:subStr]) {
                        length = 2;
                    }
                }
                self.inputTextView.attributedText = [self backspaceText:attr length:length];
            }
        } else {
            if (chatText.length >= 2)
            {
                NSString *subStr = [chatText substringFromIndex:chatText.length-2];
                if ([(YQHFaceView *)self.faceView stringIsFace:subStr]) {
                    self.inputTextView.text = [chatText substringToIndex:chatText.length-2];
                    [self textViewDidChange:self.inputTextView];
                    return;
                }
            }
            
            if (chatText.length > 0) {
                self.inputTextView.text = [chatText substringToIndex:chatText.length-1];
            }
        }
    }
    
    [self textViewDidChange:self.inputTextView];
}

-(NSMutableAttributedString*)backspaceText:(NSMutableAttributedString*) attr length:(NSInteger)length
{
    NSRange range = [self.inputTextView selectedRange];
    if (range.location == 0) {
        return attr;
    }
    [attr deleteCharactersInRange:NSMakeRange(range.location - length, length)];
    return attr;
}

- (void)sendFace
{
    NSString *chatText = self.inputTextView.text;
    if (chatText.length > 0) {
        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
            
            if (![_inputTextView.text isEqualToString:@""]) {
                
                //转义回来
                NSMutableString *attStr = [[NSMutableString alloc] initWithString:self.inputTextView.attributedText.string];
                [_inputTextView.attributedText enumerateAttribute:NSAttachmentAttributeName
                                                          inRange:NSMakeRange(0, self.inputTextView.attributedText.length)
                                                          options:NSAttributedStringEnumerationReverse
                                                       usingBlock:^(id value, NSRange range, BOOL *stop)
                 {
                     if (value) {
                         YQHTextAttachment* attachment = (YQHTextAttachment*)value;
                         NSString *str = [NSString stringWithFormat:@"%@",attachment.imageName];
                         [attStr replaceCharactersInRange:range withString:str];
                     }
                 }];
                [self.delegate didSendText:attStr];
                self.inputTextView.text = @"";
                [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];;
            }
        }
    }
}

- (void)sendFaceWithEmotion:(YQHEmotion *)emotion
{
    if (emotion) {
        if ([self.delegate respondsToSelector:@selector(didSendText:withExt:)]) {
            [self.delegate didSendText:emotion.emotionTitle withExt:@{@"em_emotion":emotion}];
            [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];;
        }
    }
}

#pragma mark - UIKeyboardNotification

#warning 这里有问题  本项目中采取 和 实际中采取不一致

- (void)chatKeyboardWillChangeFrame:(NSNotification *)notification
{
    
    //添加表情输入和键盘切换之间没有回调
    //本项目中取消动画
//    if (_delegate && [_delegate respondsToSelector:@selector(chatToolbarDidChangeFrameToHeight:)]) {
//        [_delegate chatToolbarDidChangeFrameToHeight:self.frame.size.height];
//    }
    
    
    //键盘弹出时间不一致
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    
    void(^animations)(void) = ^{
        [self _willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:nil];
}

#pragma mark - action

- (void)styleButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        for (YQHChatToolbarItem *item in self.rightItems) {
            item.button.selected = NO;
        }
        
        for (YQHChatToolbarItem *item in self.leftItems) {
            if (item.button != button) {
                item.button.selected = NO;
            }
        }
        
        [self _willShowBottomView:nil];
    
        self.inputTextView.text = @"";
        [self textViewDidChange:self.inputTextView];
        [self.inputTextView resignFirstResponder];
    }else{
        [self.inputTextView becomeFirstResponder];
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.recordButton.hidden = !button.selected;
        self.inputTextView.hidden = button.selected;
    } completion:nil];
}

- (void)faceButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    YQHChatToolbarItem *faceItem = nil;
    for (YQHChatToolbarItem *item in self.rightItems) {
        if (item.button == button){
            faceItem = item;
            continue;
        }
        
        item.button.selected = NO;
    }
    
    for (YQHChatToolbarItem *item in self.leftItems) {
        item.button.selected = NO;
    }
    
    if (button.selected) {
        [self.inputTextView resignFirstResponder];
        
        [self _willShowBottomView:faceItem.button2View];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.recordButton.hidden = button.selected;
            self.inputTextView.hidden = !button.selected;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [self.inputTextView becomeFirstResponder];
    }
}

- (void)moreButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    YQHChatToolbarItem *moreItem = nil;
    for (YQHChatToolbarItem *item in self.rightItems) {
        if (item.button == button){
            moreItem = item;
            continue;
        }
        
        item.button.selected = NO;
    }
    
    for (YQHChatToolbarItem *item in self.leftItems) {
        item.button.selected = NO;
    }
    
    if (button.selected) {
        [self.inputTextView resignFirstResponder];
        
        [self _willShowBottomView:moreItem.button2View];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.recordButton.hidden = button.selected;
            self.inputTextView.hidden = !button.selected;
        } completion:nil];
    }else
    {
        [self.inputTextView becomeFirstResponder];
        //添加 回调
        if (_delegate && [_delegate respondsToSelector:@selector(chatToolbarDidChangeFrameToHeight:)]) {
            [_delegate chatToolbarDidChangeFrameToHeight:self.frame.size.height];
        }
    }
}

- (void)recordButtonTouchDown
{
    __weak __typeof(&*self)weakSelf = self;
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        
        if (granted) {
            
            // 用户同意获取数据
            
            //DLog(@"麦克风打开了");
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didStartRecordingVoiceAction:)]) {
                [weakSelf.delegate didStartRecordingVoiceAction:weakSelf.recordView];
            }
            
        } else {
            
            // 可以显示一个提示框告诉用户这个app没有得到允许？
            
            NSLog(@"麦克风关闭了");
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:[NSString stringWithFormat:@"亿起点需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"]
                                       delegate:nil
                              cancelButtonTitle:@"好"
                              otherButtonTitles:nil] show];
            return;
            
        }
        
    }];
    
    
}

- (void)recordButtonTouchUpOutside
{
    if (_delegate && [_delegate respondsToSelector:@selector(didCancelRecordingVoiceAction:)])
    {
        [_delegate didCancelRecordingVoiceAction:self.recordView];
    }
}
//语音聊天
- (void)recordButtonTouchUpInside
{
    self.recordButton.enabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(didFinishRecoingVoiceAction:)])
    {
        [self.delegate didFinishRecoingVoiceAction:self.recordView];
    }
    self.recordButton.enabled = YES;
}

- (void)recordDragOutside
{
    if ([self.delegate respondsToSelector:@selector(didDragOutsideAction:)])
    {
        [self.delegate didDragOutsideAction:self.recordView];
    }
}

- (void)recordDragInside
{
    if ([self.delegate respondsToSelector:@selector(didDragInsideAction:)])
    {
        [self.delegate didDragInsideAction:self.recordView];
    }
}

#pragma mark - public


- (BOOL)endEditing:(BOOL)force
{
    BOOL result = [super endEditing:force];
    
    for (YQHChatToolbarItem *item in self.rightItems) {
        item.button.selected = NO;
    }
    [self _willShowBottomView:nil];
    
    return result;
}

- (void)cancelTouchRecord
{
    if ([_recordView isKindOfClass:[YQHRecordView class]]) {
        [(YQHRecordView *)_recordView recordButtonTouchUpInside];
        [_recordView removeFromSuperview];
    }
}

- (void)willShowBottomView:(UIView *)bottomView
{
    [self _willShowBottomView:bottomView];
}

@end
