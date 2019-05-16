//
//  YQHChatGroupDetailCell1.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YQHGroupViewDelegate <NSObject>

@optional
-(void)moreGroupMembersClick;
-(void)imageClick:(NSString*)ID;
@end

@class YQHChatGroupModel;
@interface YQHChatGroupDetailCell1 : UITableViewCell

@property (nonatomic, strong) YQHChatGroupModel* chatGroupModel;

@property (nonatomic, strong) NSArray* groupMembers;

@property (nonatomic, weak) id<YQHGroupViewDelegate> groupViewDelegate;


//头像
@property (nonatomic, strong) UIImageView* imageView1;
@property (nonatomic, strong) UIImageView* imageView2;
@property (nonatomic, strong) UIImageView* imageView3;
@property (nonatomic, strong) UIImageView* imageView4;

@property (nonatomic, strong) UIImageView* imageView5;
@property (nonatomic, strong) UIImageView* imageView6;
@property (nonatomic, strong) UIImageView* imageView7;
@property (nonatomic, strong) UIImageView* imageView8;

@property (nonatomic, strong) UIImageView* imageView9;
@property (nonatomic, strong) UIImageView* imageView10;
@property (nonatomic, strong) UIImageView* imageView11;
@property (nonatomic, strong) UIImageView* imageView12;

@property (nonatomic, strong) UIImageView* imageViewPlus;
@property (nonatomic, strong) UIImageView* imageViewMinus;

@property (nonatomic, strong) UILabel* label1;
@property (nonatomic, strong) UILabel* label2;
@property (nonatomic, strong) UILabel* label3;
@property (nonatomic, strong) UILabel* label4;
@property (nonatomic, strong) UILabel* label5;
@property (nonatomic, strong) UILabel* label6;
@property (nonatomic, strong) UILabel* label7;
@property (nonatomic, strong) UILabel* label8;

@property (nonatomic, strong) UILabel* label9;
@property (nonatomic, strong) UILabel* label10;

@property (nonatomic, strong) NSArray* imageArray;

@property (nonatomic, strong) NSArray* labelArray;

@end

