//
//  YQHChatUserDetailCell.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatUserDetailCell.h"
#import "YQHChatContactModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "chatConst.h"

@interface YQHChatUserDetailCell()

@end

@implementation YQHChatUserDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化子视图
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    // 头像
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 60)];
    [self.contentView addSubview:_avatarView];
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.cornerRadius = 30;
    //_avatarView.backgroundColor=[UIColor redColor];

    _nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLabel];
    _nameLabel.text=@"";
    _nameLabel.font=[UIFont systemFontOfSize:18];
    _nameLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];//RGB(51, 51, 51);
    //_nameLabel.backgroundColor=[UIColor grayColor];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(22.5);
    }];

    _gradeIcon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_userinfo_grade"]];//WithFrame:CGRectMake(0, 0, 18, 12.5)
    [self.contentView addSubview:_gradeIcon];
    [_gradeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(20);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.width.equalTo(@19);
        make.height.equalTo(@19);
    }];
    //_gradeIcon.backgroundColor=[UIColor greenColor];

    _gradeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_gradeLabel];
    _gradeLabel.text=@"一级教师 博士";
    _gradeLabel.font=[UIFont systemFontOfSize:14];
    _gradeLabel.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];//RGB(136, 136, 136);
    //_gradeLabel.backgroundColor=[UIColor redColor];
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gradeIcon.mas_right).offset(20);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7);
        make.width.equalTo(@400);
        make.height.equalTo(@25);
    }];
}

-(void)setContactModel:(YQHChatContactModel *)contactModel{
    if (contactModel.imageUrl&&[contactModel.imageUrl length]>0) {
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:contactModel.imageUrl] placeholderImage:chatMessageAvatarImageBg options:SDWebImageRefreshCached];
    }else{
        _avatarView.image=chatMessageAvatarImageBg;
    }
    _nameLabel.text=contactModel.userName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

