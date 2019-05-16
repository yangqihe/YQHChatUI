//
//  YQHChatGroupDetailCell3.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatGroupDetailCell3.h"
#import "YQHChatGroupModel.h"
#import <Masonry/Masonry.h>

@interface YQHChatGroupDetailCell3()

//个人简介标题
@property (strong, nonatomic) UILabel *descriptionTitleLabel;

//个人简介内容
@property (strong, nonatomic) UILabel *descriptionContentLabel;

@end

@implementation YQHChatGroupDetailCell3

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
    _descriptionTitleLabel.text=@"群简介";
    _descriptionTitleLabel.font=[UIFont systemFontOfSize:15];
    _descriptionTitleLabel.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];//RGB(51, 51, 51);
    [_descriptionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        //make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    //_descriptionTitleLabel.backgroundColor=[UIColor redColor];
    
    NSString* des=@"";
    
    
    //CGSize labelSize = [des sizeWithFont:[UIFont systemFontOfSize:14]constrainedToSize:CGSizeMake(200.0, 5000)lineBreakMode:UILineBreakModeWordWrap];
    //_descriptionContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    
    _descriptionContentLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)
    _descriptionContentLabel.numberOfLines = 0;
    _descriptionContentLabel.preferredMaxLayoutWidth = 300;
    [_descriptionContentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:des];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [des length])];
    [_descriptionContentLabel setAttributedText:attributedString1];
    [_descriptionContentLabel sizeToFit];
    
    [self.contentView addSubview:_descriptionContentLabel];
    _descriptionContentLabel.text=des;
    _descriptionContentLabel.font=[UIFont systemFontOfSize:14];
    _descriptionContentLabel.textColor=[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];//RGB(102, 102, 102);
    [_descriptionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(self.descriptionTitleLabel.mas_bottom).offset(7);//设置了行间距  次距离减小
    }];
}

-(void)setChatGroupModel:(YQHChatGroupModel *)chatGroupModel{
    if ([chatGroupModel isKindOfClass:[YQHChatGroupModel class]]) {
        _descriptionContentLabel.text=chatGroupModel.groupDescription;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
