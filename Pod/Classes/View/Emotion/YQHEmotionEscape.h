//
//  YQHEmotionEscape.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YQHEmotionEscape : NSObject

+ (YQHEmotionEscape *)sharedInstance;

+ (NSMutableAttributedString *) attributtedStringFromText:(NSString *) aInputText;

+ (NSAttributedString *) attStringFromTextForChatting:(NSString *) aInputText;

+ (NSAttributedString *) attStringFromTextForInputView:(NSString *) aInputText;

- (NSAttributedString *) attStringFromTextForChatting:(NSString *) aInputText textFont:(UIFont*)font;

- (NSAttributedString *) attStringFromTextForInputView:(NSString *) aInputText textFont:(UIFont*)font;

- (void) setEaseEmotionEscapePattern:(NSString*)pattern;

- (void) setEaseEmotionEscapeDictionary:(NSDictionary*)dict;

@end

@interface YQHTextAttachment : NSTextAttachment

@property(nonatomic, strong) NSString *imageName;

@end
