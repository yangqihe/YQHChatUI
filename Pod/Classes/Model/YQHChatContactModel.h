//
//  YQHContactModel.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 联系人
 */

@interface YQHChatContactModel : NSObject<NSCoding>

//用户的UUID
@property(nonatomic, assign) SInt64 uid;

//用户的唯一标识
@property (nonatomic, strong) NSString* ID;

//用户的头像
@property (nonatomic, strong) NSString* imageUrl;

//用户的实际显示名称
@property (nonatomic, strong) NSString* userName;

//用户的详细信息
@property (nonatomic, strong) NSString* detailText;

@property (nonatomic, strong) NSString* introduce;

@property (nonatomic, strong) NSString* accountNo;

@property (nonatomic, strong) NSString* desc;

@property (nonatomic, strong) NSString* honor;

//多姓名标签映射
@property (nonatomic, strong) NSDictionary* tagMap;

@end

