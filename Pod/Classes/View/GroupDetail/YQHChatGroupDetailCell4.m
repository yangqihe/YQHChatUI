//
//  YQHChatGroupDetailCell4.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatGroupDetailCell4.h"
#import <Masonry/Masonry.h>
#import "chatConst.h"

@interface YQHChatGroupDetailCell4()



@end

@implementation YQHChatGroupDetailCell4

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
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];
    _label.font=[UIFont systemFontOfSize:18];
    _label.textColor=[UIColor colorWithRed:254/255.0f green:80/255.0f blue:2/255.0f alpha:1.0];//RGB(254, 80, 2);
    CGFloat start=(SCREEN_WIDTH-72)/2;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(start);
        make.width.equalTo(@75);
        make.height.equalTo(@25);
        make.top.equalTo(self.contentView.mas_top).offset(12.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
