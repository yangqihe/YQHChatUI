//
//  YQHChatUserDetailCell2.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatUserDetailCell2.h"
#import <Masonry/Masonry.h>


@interface YQHChatUserDetailCell2()
//
////头像
//@property (strong, nonatomic) UIImageView *avatarView;
//
////姓名
//@property (strong, nonatomic) UILabel *nameLabel;
//
////教师级别 标签
//@property (strong, nonatomic) UIImageView *gradeIcon;
//
////教师级别
//@property (strong, nonatomic) UILabel *gradeLabel;

//教师学历
//@property (strong, nonatomic) UIImageView *educationLabel;

////教师电话标签
//@property (strong, nonatomic) UIImageView *mobileIcon;
//
////教师电话
//@property (strong, nonatomic) UILabel *mobileLabel;



////主要成就标题
//@property (strong, nonatomic) UILabel *achievementTitleLabel;
//
////主要成就内容
//@property (strong, nonatomic) UILabel *achievementContentLabel;

@end

@implementation YQHChatUserDetailCell2

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
    
        _descriptionTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_descriptionTitleLabel];
        _descriptionTitleLabel.text=@"个人简介";
        _descriptionTitleLabel.font=[UIFont systemFontOfSize:17];
        _descriptionTitleLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];//RGB(51, 51, 51);
        [_descriptionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).offset(15);
            make.width.height.mas_greaterThanOrEqualTo(0);
        }];
    [_descriptionTitleLabel sizeToFit];
    

    NSString* des=@"";
    
    _descriptionContentLabel = [[UILabel alloc] init];
    //_descriptionContentLabel.backgroundColor=[UIColor grayColor];
    _descriptionContentLabel.numberOfLines = 0;
    //_descriptionContentLabel.preferredMaxLayoutWidth = 300;
    //[_descriptionContentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:des];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [des length])];
    [_descriptionContentLabel setAttributedText:attributedString1];
    [_descriptionContentLabel sizeToFit];
    
    [self.contentView addSubview:_descriptionContentLabel];
    _descriptionContentLabel.text=des;
    _descriptionContentLabel.font=[UIFont systemFontOfSize:14];
    _descriptionContentLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];//RGB(102, 102, 102);
    [_descriptionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(self.descriptionTitleLabel.mas_bottom).offset(15);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
