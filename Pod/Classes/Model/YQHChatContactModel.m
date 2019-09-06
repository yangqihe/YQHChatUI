//
//  YQHContactModel.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatContactModel.h"

@implementation YQHChatContactModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.detailText forKey:@"detailText"];
    [aCoder encodeObject:self.introduce forKey:@"introduce"];
    [aCoder encodeObject:self.accountNo forKey:@"accountNo"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.honor forKey:@"honor"];
    [aCoder encodeObject:self.tagMap forKey:@"tagMap"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.uid = [aDecoder decodeInt64ForKey:@"uid"];
    self.ID = [aDecoder decodeObjectForKey:@"ID"];
    self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.detailText = [aDecoder decodeObjectForKey:@"detailText"];
    self.introduce = [aDecoder decodeObjectForKey:@"introduce"];
    self.accountNo = [aDecoder decodeObjectForKey:@"accountNo"];
    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    self.honor = [aDecoder decodeObjectForKey:@"honor"];
    self.tagMap = [aDecoder decodeObjectForKey:@"tagMap"];
    return self;
}


@end
