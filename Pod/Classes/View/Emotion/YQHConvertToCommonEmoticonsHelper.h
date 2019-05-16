//
//  YQHConvertToCommonEmoticonsHelper.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YQHConvertToCommonEmoticonsHelper : NSObject

+ (NSString *)convertToCommonEmoticons:(NSString *)text;

+ (NSString *)convertToSystemEmoticons:(NSString *)text;

@end

