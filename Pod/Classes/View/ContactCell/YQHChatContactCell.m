//
//  YQHChatContactCell.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatContactCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YQHChatDefine.h"
#import <Masonry/Masonry.h>

@interface YQHChatContactCell()

@end

@implementation YQHChatContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化子视图
        [self initLayout];
    }
    return self;
}

//绘制分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    //    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context,  [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0].CGColor);
    CGContextStrokeRect(context, CGRectMake(0.5, rect.size.height, rect.size.width, 0.5));
}

- (void)initLayout
{
    // 头像
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 40, 40)];
    self.avatarView.layer.masksToBounds = YES;
    self.avatarView.layer.cornerRadius = 20;
    [self.contentView addSubview:self.avatarView];
    

    self.detailLabel = [UILabel new];//[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)+7.5, 40, SCREEN_WIDTH-80, 15)];
    self.detailLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.detailLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    [self.contentView addSubview:self.detailLabel];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).offset(7.5);
        make.bottom.equalTo(self.avatarView.mas_bottom);
        make.width.equalTo(@(SCREEN_WIDTH-80));
        //make.height.equalTo(@15);
    }];
    
    
    //标题
    self.titleLabel = [UILabel new];//[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)+7.5, 15, SCREEN_WIDTH-80, 15)];
    ////self.titleLabel.backgroundColor = [UIColor grayColor];
    self.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    //self.titleLabel.text = @"";
    self.titleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];//RGB(51, 51, 51);
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).offset(7.5);
        make.bottom.equalTo(self.detailLabel.mas_top);
        make.width.equalTo(@(SCREEN_WIDTH-80));
    }];
}

-(void)setModel:(YQHChatContactModel *)model{
    
    if ([model.imageUrl length] > 0){
        NSString* url=model.imageUrl;
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:chatMessageAvatarImageBg options:SDWebImageRefreshCached];
    } else {
        self.avatarView.image = chatMessageAvatarImageBg;
    }
    
    if (![self.detailLabel.text length]) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.detailLabel.mas_top).offset(-10);
        }];
    }else{
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.detailLabel.mas_top);
        }];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
