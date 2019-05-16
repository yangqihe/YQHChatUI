//
//  YQHTextView.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, DXTextViewInputViewType) {
//    DXTextViewNormalInputType = 0,
//    DXTextViewTextInputType,
//    DXTextViewFaceInputType,
//    DXTextViewShareMenuInputType,
//};

@interface YQHTextView : UITextView

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) UIColor *placeHolderTextColor;

- (NSUInteger)numberOfLinesOfText;

+ (NSUInteger)maxCharactersPerLine;

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text;

@end
