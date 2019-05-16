//
//  ChatConversationCell.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatConversationCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface YQHChatConversationCell()

//标题
@property (strong, nonatomic) UILabel *titleLabel;

//小红点
@property (strong, nonatomic) UIButton *badgeView;

//消息
@property (strong, nonatomic) UILabel *detailLabel;

//时间
@property (strong, nonatomic) UILabel *timeLabel;

//九宫格图片
@property (nonatomic, strong) UIView* avatarView1;

@property (nonatomic, strong) UIImageView* imageView1;

@property (nonatomic, strong) UIImageView* imageView2;

@property (nonatomic, strong) UIImageView* imageView3;

@property (nonatomic, strong) UIImageView* imageView4;

@property (nonatomic, strong) UIImageView* imageView5;

@property (nonatomic, strong) UIImageView* imageView6;

@property (nonatomic, strong) UIImageView* imageView7;

@property (nonatomic, strong) UIImageView* imageView8;

@property (nonatomic, strong) UIImageView* imageView9;

@property (nonatomic, strong) NSArray* imageViews;

@end

@implementation YQHChatConversationCell

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
    CGContextStrokeRect(context, CGRectMake(75, rect.size.height, rect.size.width, 0.5));
}

- (void)initLayout
{
    self.imageView1=[[UIImageView alloc] init];
    self.imageView2=[[UIImageView alloc] init];
    self.imageView3=[[UIImageView alloc] init];
    self.imageView4=[[UIImageView alloc] init];
    self.imageView5=[[UIImageView alloc] init];
    self.imageView6=[[UIImageView alloc] init];
    self.imageView7=[[UIImageView alloc] init];
    self.imageView8=[[UIImageView alloc] init];
    self.imageView9=[[UIImageView alloc] init];
    
    //self.imageViews=[NSArray arrayWithObjects:@[@""] count:nil];
    
    // 头像
    self.imageViews = [NSArray arrayWithObjects:self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5,self.imageView6,self.imageView7,self.imageView8,self.imageView9, nil];
    
    
    // 头像
//    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 50, 50)];//图片的大小 66,66 50 ，50
    //self.headerImageView.backgroundColor = [UIColor orangeColor];
//    self.avatarView.layer.masksToBounds = YES;
//    self.avatarView.layer.cornerRadius = 25;
//    [self.contentView addSubview:self.avatarView];
    
    self.avatarView1= [[UIView alloc] initWithFrame:CGRectMake(15, 18, 50, 50)];
    [self.avatarView1 setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.6]];
    self.avatarView1.layer.cornerRadius=25;
    self.avatarView1.layer.masksToBounds=YES;
    [self.contentView addSubview:self.avatarView1];
    
    [self.avatarView1 addSubview:self.imageView1];
    [self.avatarView1 addSubview:self.imageView2];
    [self.avatarView1 addSubview:self.imageView3];
    [self.avatarView1 addSubview:self.imageView4];
    [self.avatarView1 addSubview:self.imageView5];
    [self.avatarView1 addSubview:self.imageView6];
    [self.avatarView1 addSubview:self.imageView7];
    [self.avatarView1 addSubview:self.imageView8];
    [self.avatarView1 addSubview:self.imageView9];
    
    //小红点
    self.badgeView = [UIButton buttonWithType:UIButtonTypeCustom];//WithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)-20, CGRectGetMinY(self.avatarView.frame)-4, 16, 16)
    self.badgeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.badgeView.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeView.clipsToBounds = YES;
    //self.badgeView.titleLabel.textColor = [UIColor whiteColor];
    self.badgeView.backgroundColor = [UIColor colorWithRed:247/255.0 green:64/255.0 blue:64/255.0 alpha:1/1.0];
    
    [self.badgeView setBackgroundImage:[UIImage imageNamed:@"chat_message_dot"] forState:UIControlStateNormal];
    [self.badgeView setBackgroundImage:[UIImage imageNamed:@"chat_message_dot"] forState:UIControlStateHighlighted];
    
    self.badgeView.titleLabel.font = [UIFont systemFontOfSize:10];
    self.badgeView.layer.cornerRadius = 8;
    [self.badgeView setTitle:@"" forState:UIControlStateNormal];
    [self.contentView addSubview:self.badgeView];
    
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@16);
        make.height.equalTo(@16);
        make.right.equalTo(self.avatarView1.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    
    //标题
    self.titleLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)+10, 23, SCREEN_WIDTH-215, 15)
    //self.titleLabel.backgroundColor = [UIColor grayColor];
    self.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:17];
    self.titleLabel.text = @"";
    self.titleLabel.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1.0];//RGB(51, 51, 51);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView1.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(22);
        make.height.equalTo(@19);
        make.width.equalTo(@(SCREEN_WIDTH-160));
    }];
    
    
    //时间
    self.timeLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(SCREEN_WIDTH-15-32-40, 25, 32+40, 12)
    self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.timeLabel.text = @"15:30";
    self.timeLabel.textAlignment=NSTextAlignmentRight;
    self.timeLabel.textColor = [UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1.0];//RGB(187, 187, 187);//[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0];
    //self.timeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(23.5);
        make.width.equalTo(@70);
    }];
                                                               
    // 详情
    self.detailLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)+10,CGRectGetMaxY(self.titleLabel.frame)+12, SCREEN_WIDTH-120, 12)
    self.detailLabel.text = @"";
    self.detailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.detailLabel.textColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];//RGB(136, 136, 136);//;[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    //self.detailLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView1.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12.5);
        make.height.equalTo(@15);
        make.width.equalTo(@(SCREEN_WIDTH-100));
    }];
    

}

//实体
-(void)setModel:(YQHChatConversationModel *)model{
    _model = model;
    
    self.titleLabel.text = _model.title;
    
    self.timeLabel.text = model.timeText;
    if (model.unreadMessagesCount>0) {
        self.badgeView.hidden=NO;
        [self.badgeView setTitle:[NSString stringWithFormat:@"%d",model.unreadMessagesCount] forState:UIControlStateNormal];
    }else{
        self.badgeView.hidden=YES;
    }
    self.detailLabel.text=model.contentText;
    
    //如果是群组的图片去除  聊天圆角
    //if (model.chatType==YQHGroupChatType) {
        //self.avatarView.layer.cornerRadius = 0;
    //}
    
    //[imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl width:imgView.width height:imgView.height cornerRadius:5]];
}

-(void)calculateAvatarView:(NSArray *)group{
    CGFloat viewWidth = 50;//200;
    
    NSInteger avatarCount = group.count > 9 ? 9 : group.count;
    CGFloat width = viewWidth / 3 * 0.85;
    CGFloat space3 = (viewWidth - width * 3) / 4;                      // 三张图时的边距（图与图之间的边距）
    CGFloat space2 = (viewWidth - width * 2 + space3) / 2;             // 两张图时的边距
    CGFloat space1 = (viewWidth - width) / 2;                          // 一张图时的边距
    CGFloat y = avatarCount > 6 ? space3 : (avatarCount > 3 ? space2 : space1);
    CGFloat x = avatarCount  % 3 == 0 ? space3 : (avatarCount % 3 == 2 ? space2 : space1);
    width = avatarCount > 4 ? width : (avatarCount > 1 ? (viewWidth - 3 * space3) / 2 : viewWidth );  // 重新计算width；
    
    if (avatarCount == 1) {                                          // 1,2,3,4 张图不同
        x = 0;
        y = 0;
    }
    if (avatarCount == 2) {
        x = space3;
    } else if (avatarCount == 3) {
        x = (viewWidth -width)/2;
        y = space3;
    } else if (avatarCount == 4) {
        x = space3;
        y = space3;
    }
    
    for (NSInteger i = 8; i >= 0; i--) {
        if (i>(avatarCount - 1)) {
            UIImageView* imageView=self.imageViews[i];
            imageView.hidden=YES;
        }
    }
    
    for (NSInteger i = avatarCount - 1; i >= 0; i--) {
        id obj = [group objectAtIndex:i];
        UIImageView* imageView=self.imageViews[i];
        imageView.hidden=NO;
        imageView.frame=CGRectMake(x, y, width, width);
        imageView.layer.cornerRadius = width/2;
        imageView.layer.masksToBounds = YES;
        
        CGRect rect = imageView.frame;
        rect.size.width=width;
        rect.size.height = width;
        imageView.frame=rect;
        
        if ([obj isKindOfClass:[NSString class]]) {
            if ([obj length] > 0){
                [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:chatMessageAvatarImageBg options:SDWebImageRefreshCached];
            } else {
                imageView.image = chatMessageAvatarImageBg;
                //[imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:chatMessageAvatarImageBg options:SDWebImageRefreshCached];
            }
        }else if ([obj isKindOfClass:[UIImage class]]){
            imageView.image = obj;
        }else{
            imageView.image = chatMessageAvatarImageBg;
        }
        
        if (avatarCount == 3) {
            if (i == 2) {
                y = width + space3*2;
                x = space3;
            } else {
                x += width + space3;
            }
        } else if (avatarCount == 4) {
            if (i % 2 == 0) {
                y += width +space3;
                x = space3;
            } else {
                x += width +space3;
            }
        } else {
            if (i % 3 == 0 ) {
                y += (width + space3);
                x = space3;
            } else {
                x += (width + space3);
            }
        }
        
    }
    
}

@end
