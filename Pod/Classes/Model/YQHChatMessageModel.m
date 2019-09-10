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

@implementation YQHChatMessageModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.messageId forKey:@"messageId"];
    [aCoder encodeObject:self.localMessageId forKey:@"localMessageId"];
    [aCoder encodeObject:self.conversationId forKey:@"conversationId"];
    
    [aCoder encodeObject:self.from forKey:@"from"];
    [aCoder encodeObject:self.to forKey:@"to"];
    [aCoder encodeObject:self.ext forKey:@"ext"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self.messageId = [aDecoder decodeObjectForKey:@"messageId"];
    self.localMessageId = [aDecoder decodeObjectForKey:@"localMessageId"];
    self.conversationId = [aDecoder decodeObjectForKey:@"conversationId"];
    
    self.from = [aDecoder decodeObjectForKey:@"from"];
    self.to = [aDecoder decodeObjectForKey:@"to"];
    self.ext = [aDecoder decodeObjectForKey:@"ext"];
    
    return self;
}


- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
