//
//  HQChatAvatarView.m
//  AFNetworking
//
//  Created by 杨棋贺 on 2019/8/6.
//

#import "HQChatAvatarView.h"
#import <Masonry/Masonry.h>

@implementation HQChatAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _avatarView=[UIImageView new];
        [self addSubview:_avatarView];
        
        _avatarMarkView=[UIImageView new];
        [self addSubview:_avatarMarkView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _avatarView.layer.masksToBounds=YES;
    _avatarView.layer.cornerRadius=_avatarView.frame.size.width/2;
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height).offset(-5);
        make.width.equalTo(self.mas_width).offset(-5);
    }];

    [_avatarMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
