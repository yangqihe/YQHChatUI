//
//  YQHPopMenuView.m
//  家校共享教师端
//
//  Created by 杨棋贺 on 2019/4/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHPopMenuView.h"
#import "chatConst.h"

static CGFloat const kCellHeight = 44;

@interface PopMenuTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end


@interface YQHPopMenuView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, assign) CGPoint trianglePoint;
@property (nonatomic, copy) void(^action)(NSInteger index);

@end


@implementation YQHPopMenuView

- (instancetype)initWithItems:(NSArray <NSDictionary *>*)array
                        width:(CGFloat)width
             triangleLocation:(CGPoint)point
                       action:(void(^)(NSInteger index))action
{
    if (array.count == 0) return nil;
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.alpha = 0;
        _tableData = [array copy];
        _trianglePoint = point;
        self.action = action;
        
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        
        
        // 创建tableView
        //CGFloat rightInsert = 35;
        CGFloat triangle_Y = 10;//SCREEN_WIDTH - width - rightInsert
        //这里x没有实际效果  被下面的动画效果覆盖
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(point.x-200, point.y + triangle_Y, width, kCellHeight * array.count) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.layer.masksToBounds = YES;
        //_tableView.layer.cornerRadius = 5;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = kCellHeight;
        [_tableView registerClass:[PopMenuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PopMenuTableViewCell class])];
        [self addSubview:_tableView];
        
    }
    return self;
}

+ (void)showWithItems:(NSArray <NSDictionary *>*)array
                width:(CGFloat)width
     triangleLocation:(CGPoint)point
               action:(void(^)(NSInteger index))action
{
    YQHPopMenuView *view = [[YQHPopMenuView alloc] initWithItems:array width:width triangleLocation:point action:action];
    [view show];
}

- (void)tap {
    [self hide];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return NO;
    }
    return YES;
}

#pragma mark - show or hide
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    // 设置右上角为transform的起点（默认是中心点）
    _tableView.layer.position = CGPointMake(SCREEN_WIDTH - 15, _trianglePoint.y + 5);
    // 向左下transform
    _tableView.layer.anchorPoint = CGPointMake(1, 0);
    _tableView.transform = CGAffineTransformMakeScale(CGFLOAT_MIN, CGFLOAT_MIN);
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        weakSelf.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)hide {
    self.alpha = 0;
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        //weakSelf.alpha = 0;
        weakSelf.tableView.transform = CGAffineTransformMakeScale(CGFLOAT_MIN, CGFLOAT_MIN);
    } completion:^(BOOL finished) {
        [weakSelf.tableView removeFromSuperview];
        [self removeFromSuperview];
        if (self.hideHandle) {
            self.hideHandle();
        }
    }];
}

#pragma mark - Draw triangle
- (void)drawRect:(CGRect)rect {
    // 设置背景色
    [[UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1] set];
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);
    CGPoint point = _trianglePoint;
    // 设置起点
    CGContextMoveToPoint(context, point.x, point.y);
    // 画线
    CGContextAddLineToPoint(context, point.x - 5, point.y +5);
    CGContextAddLineToPoint(context, point.x + 5, point.y +5);
    CGContextClosePath(context);
    // 设置填充色
    [[UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1] setFill];
    // 设置边框颜色
    [[UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1] setStroke];
    // 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopMenuTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = _tableData[indexPath.row];
    cell.leftImageView.image = [UIImage imageNamed:dic[@"imageName"]];
    cell.titleLabel.text = dic[@"title"];
    [cell.titleLabel sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hide];
    if (_action) {
        _action(indexPath.row);
    }
}

@end


@implementation PopMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (kCellHeight - 20) / 2, 20, 20)];
        [self.contentView addSubview:_leftImageView];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame) + 10, _leftImageView.frame.origin.y, 0, 0)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        //self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }else {
        self.backgroundColor = [UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1];;//[UIColor whiteColor];
    }
}

@end
