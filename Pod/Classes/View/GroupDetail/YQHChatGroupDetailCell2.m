//
//  YQHChatGroupDetailCell2.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatGroupDetailCell2.h"
#import "YQHChatGroupModel.h"
#import <Masonry/Masonry.h>
#import "YQHChatDefine.h"

@interface YQHChatGroupDetailCell2()

@property (nonatomic, strong) UILabel* groupNameTitleLabel;

@property (nonatomic, strong) UILabel* groupNameLabel;

//聊天置顶
@property (nonatomic, strong) UILabel* topChatConversationLabel;

//清空聊天记录
@property (nonatomic, strong) UILabel* clearChatHistoryLabel;

@property (nonatomic, strong) UIView* clearChatHistoryView;

@property (nonatomic, strong) UIView* topStateView;

@end

@implementation YQHChatGroupDetailCell2

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
    _groupNameTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_groupNameTitleLabel];
    _groupNameTitleLabel.text=@"群名称";
    _groupNameTitleLabel.font=[UIFont systemFontOfSize:15];
    _groupNameTitleLabel.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];//RGB(51, 51, 51);
    _topChatConversationLabel.backgroundColor=[UIColor grayColor];
    [_groupNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(22.5);
        make.width.equalTo(@80);
    }];
    
    
    _groupNameLabel = [[UILabel alloc] init];
    _groupNameLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer* gesture111=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture111)];
    [_groupNameLabel addGestureRecognizer:gesture111];
    
    [self.contentView addSubview:_groupNameLabel];
    _groupNameLabel.text=@"";
    _groupNameLabel.textAlignment=NSTextAlignmentRight;
    _groupNameLabel.font=[UIFont systemFontOfSize:15];
    _groupNameLabel.textColor=[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];//RGB(102, 102, 102);
    [_groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.mas_equalTo(self.contentView.left).offset(15);
        //make.top.mas_equalTo(self.contentView.mas_top).offset(22.5);
        //make.width.equalTo(@200);
        make.left.equalTo(self.groupNameTitleLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@59);
        make.centerY.equalTo(self.groupNameTitleLabel.mas_centerY);
    }];
    
    UIView *line1=[[UIView alloc] init];//WithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
    [self.contentView addSubview:line1];
    line1.backgroundColor=[UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0];//RGB(244, 244, 244);
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.groupNameTitleLabel.mas_bottom).offset(22.5);
    }];
    
    _topStateView=[[UIView alloc] init];
    UITapGestureRecognizer* gesture1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeTop)];
    [_topStateView addGestureRecognizer:gesture1];
    [self.contentView addSubview:_topStateView];
    [_topStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(line1.mas_bottom).offset(1);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@59);
    }];
    
    _topChatConversationLabel = [[UILabel alloc] init];
    [_topStateView addSubview:_topChatConversationLabel];
    _topChatConversationLabel.text=@"聊天置顶";
    _topChatConversationLabel.font=[UIFont systemFontOfSize:15];
    _topChatConversationLabel.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];//RGB(51, 51, 51);
    //_topChatConversationLabel.backgroundColor=[UIColor grayColor];
    [_topChatConversationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topStateView.mas_left).offset(15);
        make.height.mas_equalTo(31);
        make.top.mas_equalTo(line1.mas_bottom).offset(17);
    }];
    

    self.topChatConversationSwitch = [[UISwitch alloc] init];//WithFrame:CGRectMake(100, 100, 100, 30)
    //self.topChatConversationSwitch.backgroundColor=[UIColor grayColor];
    [self.topStateView addSubview:self.topChatConversationSwitch];
    [self.topChatConversationSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(31);
        make.right.mas_equalTo(self.topStateView.mas_right).offset(-15);
        //make.top.mas_equalTo(self.topChatConversationLabel.top);//.offset(22.5);
        make.top.mas_equalTo(line1.mas_bottom).offset(17);
    }];
    
    
    
    
    
    UIView *line2=[[UIView alloc] init];//WithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
    [self.contentView addSubview:line2];
    line2.backgroundColor=[UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0];//RGB(244, 244, 244);
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.topStateView.mas_bottom).offset(17);
    }];
    

    
    self.notDisturbSwitch = [[UISwitch alloc] init];
    [self.contentView addSubview:self.notDisturbSwitch];
    [self.notDisturbSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(31);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(line2.mas_bottom).offset(17);
    }];
    
    
    
    UILabel *notDisturb = [[UILabel alloc] init];
    notDisturb.userInteractionEnabled=YES;
    UITapGestureRecognizer* gesture11=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture11)];
    [notDisturb addGestureRecognizer:gesture11];
    
    [self.contentView addSubview:notDisturb];
    notDisturb.text=@"消息免打扰";
    notDisturb.font=[UIFont systemFontOfSize:15];
    notDisturb.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];//RGB(51, 51, 51);
    [notDisturb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.height.mas_equalTo(31);
        make.top.mas_equalTo(line2.mas_bottom).offset(17);
        make.right.equalTo(self.notDisturbSwitch.mas_left);
    }];
    
    [self.notDisturbSwitch addTarget:self action:@selector(notDisturbSwitchChanged:) forControlEvents:(UIControlEventValueChanged)];
    
    
    
    
    
    UIView *line=[[UIView alloc] init];//WithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
    [self.contentView addSubview:line];
    line.backgroundColor=[UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0];//RGB(244, 244, 244);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(notDisturb.mas_bottom).offset(17);
    }];
    
    [self.topChatConversationSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:(UIControlEventValueChanged)];
    
    _clearChatHistoryView=[[UIView alloc] init];
    //_clearChatHistoryView.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:_clearChatHistoryView];
    [_clearChatHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(line.mas_bottom).offset(1);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@59);
    }];
    
    UITapGestureRecognizer* gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearHistory)];
    [_clearChatHistoryView addGestureRecognizer:gesture];
    _clearChatHistoryLabel = [[UILabel alloc] init];
    [_clearChatHistoryView addSubview:_clearChatHistoryLabel];
    _clearChatHistoryLabel.text=@"清空聊天记录";
    _clearChatHistoryLabel.font=[UIFont systemFontOfSize:15];
    _clearChatHistoryLabel.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];//RGB(51, 51, 51);
    //_clearChatHistoryLabel.backgroundColor=[UIColor redColor];
    [_clearChatHistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(line.mas_bottom).offset(22.5);
    }];
}

-(void)gesture111{
    if (_itemDelegate) {
        [_itemDelegate itemClick:101];
    }
}

-(void)gesture11{
    if (_itemDelegate) {
        [_itemDelegate itemClick:102];
    }
}

-(void)makeTop{
    //NSLog(@"");
}

-(void)setChatGroupModel:(YQHChatGroupModel *)chatGroupModel{
    _groupNameLabel.text=chatGroupModel.subject;
}

-(void)switchChanged:(UISwitch*)btn{
    if (btn.on) {
        if (_itemDelegate) {
            [_itemDelegate itemClick:1];
        }
    }else{
        if (_itemDelegate) {
            [_itemDelegate itemClick:2];
        }
    }
}

-(void)notDisturbSwitchChanged:(UISwitch*)btn{
    if (btn.on) {
        if (_itemDelegate) {
            [_itemDelegate itemClick:4];
        }
    }else{
        if (_itemDelegate) {
            [_itemDelegate itemClick:5];
        }
    }
}


-(void)clearHistory{
    if (self.itemDelegate) {
        [self.itemDelegate itemClick:3];
        //[weakSelf showHint:@"已清空聊天记录"];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
