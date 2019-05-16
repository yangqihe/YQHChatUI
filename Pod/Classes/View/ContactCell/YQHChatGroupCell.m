//
//  YQHChatGroupCell.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatGroupCell.h"
#import "YQHChatGroupModel.h"
#import "chatConst.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface YQHChatGroupCell()

//头像
//@property (strong, nonatomic) UIImageView *avatarView;

//姓名
@property (strong, nonatomic) UILabel *titleLabel;


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

@implementation YQHChatGroupCell

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
//    // 头像
//    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 40, 40)];
//    self.avatarView.layer.masksToBounds = YES;
//    self.avatarView.layer.cornerRadius = 20;
//    [self.contentView addSubview:self.avatarView];
    
    
    self.imageView1=[[UIImageView alloc] init];
    self.imageView2=[[UIImageView alloc] init];
    self.imageView3=[[UIImageView alloc] init];
    self.imageView4=[[UIImageView alloc] init];
    self.imageView5=[[UIImageView alloc] init];
    self.imageView6=[[UIImageView alloc] init];
    self.imageView7=[[UIImageView alloc] init];
    self.imageView8=[[UIImageView alloc] init];
    self.imageView9=[[UIImageView alloc] init];
    
    // 头像
    self.imageViews = [NSArray arrayWithObjects:self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5,self.imageView6,self.imageView7,self.imageView8,self.imageView9, nil];
    
    self.avatarView1= [[UIView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
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
    
    
    
    
    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarView1.frame)+7.5, 25, SCREEN_WIDTH-90, 17)];
    ////self.titleLabel.backgroundColor = [UIColor grayColor];
    self.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    self.titleLabel.text = @"";
    self.titleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];;
    [self.contentView addSubview:self.titleLabel];
    
}

-(void)setModel:(YQHChatGroupModel *)model{
    self.titleLabel.text=model.subject;

//    if ([model.imageUrl length] > 0){
//        NSString* url=model.imageUrl;
//        //NSLog(@"%@",url);
//        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:chatMessageAvatarImageBg options:SDWebImageRefreshCached];
//    } else {
//        self.avatarView.image = chatMessageAvatarImageBg;
//    }
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
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
    //[view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.6]];
    
    for (NSInteger i = 8; i >= 0; i--) {
        if (i>(avatarCount - 1)) {
            UIImageView* imageView=self.imageViews[i];
            imageView.hidden=YES;
        }
    }
    
    //__block NSInteger count = 0;               //下载图片完成的计数
    for (NSInteger i = avatarCount - 1; i >= 0; i--) {
        id obj = [group objectAtIndex:i];
        UIImageView* imageView=self.imageViews[i];
        imageView.hidden=NO;
        //CGSize size=CGSizeMake(width, width);
        imageView.frame=CGRectMake(x, y, width, width);
        //imageView.backgroundColor=[UIColor grayColor];
        imageView.layer.cornerRadius = width/2;
        imageView.layer.masksToBounds = YES;
        CGRect rect = imageView.frame;
        rect.size.width=width;
        rect.size.height = width;
        imageView.frame=rect;
        
        //NSLog(@"%f %f %f",x,y,width);
        //NSLog(@"---%@",NSStringFromCGRect(imageView.frame));
        
        if ([obj isKindOfClass:[NSString class]]) {
            if ([obj length] > 0){
                [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:chatMessageAvatarImageBg options:SDWebImageRefreshCached];
            } else {
                imageView.image = chatMessageAvatarImageBg;
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
