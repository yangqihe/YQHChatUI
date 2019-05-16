//
//  YQHChatMenuButton.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatMenuButton.h"

@interface YQHChatMenuButton()

@property (copy, nonatomic) YQHChatMenuButtonBlock clickBlock;

@end

@implementation YQHChatMenuButton

-(instancetype)initWithFrame:(CGRect)frame withImage:(UIImage*)image withHightImage:(UIImage*)hightImage withText:(NSString*)text withClickBlock:(YQHChatMenuButtonBlock)block{
    self = [super initWithFrame:frame];
    _clickBlock=block;
    self.userInteractionEnabled=YES;
    if (self) {
        [self setupSubViews:image withHightImage:hightImage withText:text];
    }
    return self;
}

-(void)setupSubViews:(UIImage*)image withHightImage:(UIImage*)hightImage withText:(NSString*)text{
    //UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:hightImage forState:UIControlStateHighlighted];
    //[btn addTarget:self action:@"btnClick" forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 45+5, 45, 45)];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,45+5,45,11);
    label.text = @"拍照";
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:11];
    label.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1/1.0];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=text;
    [self addSubview:label];
}

-(void)btnClick{
    _clickBlock();
}

@end
