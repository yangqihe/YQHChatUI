//
//  YQHChatUserDetailCell3.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatUserDetailCell3.h"
#import <Masonry/Masonry.h>

@interface YQHChatUserDetailCell3()

//头像
@property (strong, nonatomic) UIImageView *avatarView;

//姓名
@property (strong, nonatomic) UILabel *nameLabel;

//教师级别 标签
@property (strong, nonatomic) UIImageView *gradeIcon;

//教师级别
@property (strong, nonatomic) UILabel *gradeLabel;

//教师学历
//@property (strong, nonatomic) UIImageView *educationLabel;

//教师电话标签
@property (strong, nonatomic) UIImageView *mobileIcon;

//教师电话
@property (strong, nonatomic) UILabel *mobileLabel;

//个人简介标题
@property (strong, nonatomic) UILabel *descriptionTitleLabel;

//个人简介内容
@property (strong, nonatomic) UILabel *descriptionContentLabel;

//主要成就标题
@property (strong, nonatomic) UILabel *achievementTitleLabel;




@end

@implementation YQHChatUserDetailCell3

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
    
    
    _achievementTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_achievementTitleLabel];
    _achievementTitleLabel.text=@"主要成就";
    _achievementTitleLabel.font=[UIFont systemFontOfSize:17];
    _achievementTitleLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];//RGB(51, 51, 51);
    [_achievementTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    //_achievementTitleLabel.backgroundColor=[UIColor redColor];
    
    NSString* des=@"";
    
    _achievementContentLabel = [[UILabel alloc] init];
    _achievementContentLabel.numberOfLines = 0;
    
//    _achievementContentLabel.preferredMaxLayoutWidth = 300;
//    [_achievementContentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:des];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [des length])];
    [_achievementContentLabel setAttributedText:attributedString1];
    [_achievementContentLabel sizeToFit];
    
    [self.contentView addSubview:_achievementContentLabel];
    _achievementContentLabel.text=des;
    _achievementContentLabel.font=[UIFont systemFontOfSize:14];
    _achievementContentLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];//RGB(102, 102, 102);
    [_achievementContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(self.achievementTitleLabel.mas_bottom).offset(15);
    }];
    
    //_achievementContentLabel.backgroundColor=[UIColor grayColor];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
