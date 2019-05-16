//
//  YQHChatBarMoreView.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatBarMoreView.h"
#import "YQHChatMenuButton.h"

#define CHAT_BUTTON_SIZE 50
#define INSETS 10
#define MOREVIEW_COL 4
#define MOREVIEW_ROW 2
#define MOREVIEW_BUTTON_TAG 1000

const CGFloat btnWidth=45.0f;

@implementation UIView (MoreView)

- (void)removeAllSubview
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end

@interface YQHChatBarMoreView ()<UIScrollViewDelegate>
{
    YQHChatToolbarType _type;
    NSInteger _maxIndex;
}

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) YQHChatMenuButton *photoButton;
@property (nonatomic, strong) YQHChatMenuButton *takePicButton;
@property (nonatomic, strong) YQHChatMenuButton *takeVideoButton;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIButton *videoButton;
@property (nonatomic, strong) UIButton *audioCallButton;
@property (nonatomic, strong) UIButton *videoCallButton;

@end

@implementation YQHChatBarMoreView

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    //YQHChatBarMoreView *moreView = [self appearance];
}

- (instancetype)initWithFrame:(CGRect)frame type:(YQHChatToolbarType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        [self setupSubviewsForType:_type];
    }
    return self;
}

- (void)setupSubviewsForType:(YQHChatToolbarType)type
{
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _scrollview = [[UIScrollView alloc] init];
    //_scrollview.backgroundColor=[UIColor greenColor];
    _scrollview.userInteractionEnabled=YES;
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.delegate = self;
    [self addSubview:_scrollview];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 1;
    [self addSubview:_pageControl];
    
    CGFloat insets = (self.frame.size.width - 3 * btnWidth) / 6;
    
    __weak __typeof(&*self)weakSelf = self;
     _takePicButton=[[YQHChatMenuButton alloc]initWithFrame:CGRectMake(insets,10, 61, 61) withImage:[UIImage imageNamed:@"photo"] withHightImage:nil withText:@"拍摄" withClickBlock:^{
         [weakSelf takePicAction];
    }];
    //_photoButton.tag = MOREVIEW_BUTTON_TAG;
    [_scrollview addSubview:_takePicButton];
    
    
    _photoButton=[[YQHChatMenuButton alloc]initWithFrame:CGRectMake(insets * 3 + btnWidth, 10, 61, 61) withImage:[UIImage imageNamed:@"image"] withHightImage:nil withText:@"图片" withClickBlock:^{
        [weakSelf photoAction];
    }];
    //_takePicButton.tag = MOREVIEW_BUTTON_TAG + 2;
    [_scrollview addSubview:_photoButton];
    
    
    _takeVideoButton =[[YQHChatMenuButton alloc]initWithFrame:CGRectMake(insets * 5 + btnWidth*2, 10, 61, 61) withImage:[UIImage imageNamed:@"video"] withHightImage:nil withText:@"视频" withClickBlock:^{
        [weakSelf takeVideoAction];
    }];
    [_scrollview addSubview:_takeVideoButton];
    
    CGRect frame = self.frame;
    _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset =  scrollView.contentOffset;
    if (offset.x == 0) {
        _pageControl.currentPage = 0;
    } else {
        int page = offset.x / CGRectGetWidth(scrollView.frame);
        _pageControl.currentPage = page;
    }
}

#pragma mark - action

- (void)takePicAction{
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
}

- (void)photoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
        [_delegate moreViewPhotoAction:self];
    }
}

- (void)takeVideoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoAction:)]) {
        [_delegate moreViewVideoAction:self];
    }
}

- (void)locationAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewLocationAction:)]) {
        [_delegate moreViewLocationAction:self];
    }
}

- (void)takeAudioCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewAudioCallAction:)]) {
        [_delegate moreViewAudioCallAction:self];
    }
}

- (void)takeVideoCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoCallAction:)]) {
        [_delegate moreViewVideoCallAction:self];
    }
}

- (void)moreAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (button && _delegate && [_delegate respondsToSelector:@selector(moreView:didItemInMoreViewAtIndex:)]) {
        [_delegate moreView:self didItemInMoreViewAtIndex:button.tag-MOREVIEW_BUTTON_TAG];
    }
}

@end
