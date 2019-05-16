//
//  YQHContactGroupModel.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 联系人组  每组下面包含多个联系人
 */

@interface YQHContactGroupModel : NSObject

/**
 分组组的ID
 */
@property (nonatomic, strong) NSString* groupId;

/**
 分组名称
 */
@property (nonatomic, strong) NSString* groupName;

/**
 教师ID
 */
@property (nonatomic, strong) NSString* headerTeacherId;

/**
 分组下面用户的ID
 */
@property (nonatomic, strong) NSMutableArray* userIds;

@end

//groupId = 30294,
//headerTeacherId = "t357",
//groupName = "洋洋",
//userIds =     (
//               "t352",
//               "t387",
//               "t9569",
//               "t351",
//               "t28966",
//               "t417",
//               "t12409",
//               "t357",
//               "t30179",
//               "t356",
//               "t29098",
//               "t12628",
//               "t12643",
//               "t12644",
//               "t29493",
//               "t12634",
//               "t29492",
//               ),
