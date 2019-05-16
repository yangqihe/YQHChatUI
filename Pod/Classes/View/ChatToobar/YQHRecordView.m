//
//  YQHRecordView.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHRecordView.h"

#import "YQHChatCDDeviceManager.h"
#import "YQHChatCDDeviceManager+ChatMicrophone.h"

//#import "EaseLocalDefine.h"
//#import "YQHChatCDDeviceManager.h"

@interface YQHRecordView ()
{
    NSTimer *_timer;
    UIImageView *_recordAnimationView;
    UILabel *_textLabel;
    UIView *_bgView;
}

@end

@implementation YQHRecordView

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    YQHRecordView *recordView = [self appearance];
    recordView.voiceMessageAnimationImages =
//  @[@"EaseUIResource.bundle/VoiceSearchFeedback001",@"EaseUIResource.bundle/VoiceSearchFeedback002",@"EaseUIResource.bundle/VoiceSearchFeedback003",@"EaseUIResource.bundle/VoiceSearchFeedback004",@"EaseUIResource.bundle/VoiceSearchFeedback005",@"EaseUIResource.bundle/VoiceSearchFeedback006",@"EaseUIResource.bundle/VoiceSearchFeedback007",@"EaseUIResource.bundle/VoiceSearchFeedback008",@"EaseUIResource.bundle/VoiceSearchFeedback009",@"EaseUIResource.bundle/VoiceSearchFeedback010",@"EaseUIResource.bundle/VoiceSearchFeedback011",@"EaseUIResource.bundle/VoiceSearchFeedback012",@"EaseUIResource.bundle/VoiceSearchFeedback013",@"EaseUIResource.bundle/VoiceSearchFeedback014",@"EaseUIResource.bundle/VoiceSearchFeedback015",@"EaseUIResource.bundle/VoiceSearchFeedback016",@"EaseUIResource.bundle/VoiceSearchFeedback017",@"EaseUIResource.bundle/VoiceSearchFeedback018",@"EaseUIResource.bundle/VoiceSearchFeedback019",@"EaseUIResource.bundle/VoiceSearchFeedback020"];
    
// @[@"VoiceSearchFeedback001",@"VoiceSearchFeedback002",@"VoiceSearchFeedback003",@"VoiceSearchFeedback004",@"VoiceSearchFeedback005",@"VoiceSearchFeedback006",@"VoiceSearchFeedback007",@"VoiceSearchFeedback008",@"VoiceSearchFeedback009",@"VoiceSearchFeedback010",@"VoiceSearchFeedback011",@"VoiceSearchFeedback012",@"VoiceSearchFeedback013",@"VoiceSearchFeedback014",@"VoiceSearchFeedback015",@"VoiceSearchFeedback016",@"VoiceSearchFeedback017",@"VoiceSearchFeedback018",@"VoiceSearchFeedback019",@"VoiceSearchFeedback020"];
    
    
    @[@"Speech_rate1",@"Speech_rate2",@"Speech_rate3",@"Speech_rate4",@"Speech_rate5"];
    
    recordView.upCancelText = @" 手指上滑，取消发送 ";
    //NSEaseLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
    recordView.loosenCancelText = @" 松开手指，取消发送 ";
    //NSEaseLocalizedString(@"message.toolBar.record.loosenCancel", @"loosen the fingers, to cancel sending");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:0.9];;//RGBA(68, 68, 68, 0.9);//selfBlueColor;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        [self addSubview:_bgView];
        
        _recordAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, self.bounds.size.width - 50, self.bounds.size.height - 60)];
        _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback001"];
        //_recordAnimationView.image = [UIImage imageNamed:@"voice1"];
        _recordAnimationView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_recordAnimationView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                               self.bounds.size.height - 30,
                                                               self.bounds.size.width - 10,
                                                               25)];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        //_textLabel.text = @" 手指上滑，取消发送 ";
        [self addSubview:_textLabel];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.layer.cornerRadius = 5;
        _textLabel.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
        _textLabel.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - setter
- (void)setVoiceMessageAnimationImages:(NSArray *)voiceMessageAnimationImages
{
    _voiceMessageAnimationImages = voiceMessageAnimationImages;
}

- (void)setUpCancelText:(NSString *)upCancelText
{
    _upCancelText = upCancelText;
    _textLabel.text = _upCancelText;
}

- (void)setLoosenCancelText:(NSString *)loosenCancelText
{
    _loosenCancelText = loosenCancelText;
}

-(void)recordButtonTouchDown
{
    _textLabel.text = _upCancelText;
    _textLabel.backgroundColor = [UIColor clearColor];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                              target:self
                                            selector:@selector(setVoiceImage)
                                            userInfo:nil
                                             repeats:YES];
    
}

-(void)recordButtonTouchUpInside
{
    [_timer invalidate];
    _bgView.backgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:0.9];//RGBA(68, 68, 68, 0.9);
}

-(void)recordButtonTouchUpOutside
{
    [_timer invalidate];
    _bgView.backgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:0.9];;// RGBA(68, 68, 68, 0.9);
}

-(void)recordButtonDragInside
{
    [_timer setFireDate:[NSDate date]];
    _bgView.backgroundColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:0.9];//RGBA(68, 68, 68, 0.9);
    _textLabel.text = _upCancelText;
    _textLabel.backgroundColor = [UIColor clearColor];
}

-(void)recordButtonDragOutside
{
    _bgView.backgroundColor = [UIColor colorWithRed:246/255.0 green:72/255.0 blue:81/255.0 alpha:0.9];//RGBA(246, 72, 81, 0.9);
    [_timer setFireDate:[NSDate distantFuture]];
    _recordAnimationView.image = [UIImage imageNamed:@"chat-stopRecord"];
    _textLabel.text = _loosenCancelText;
}

-(void)setVoiceImage {
    _recordAnimationView.image = [UIImage imageNamed:[_voiceMessageAnimationImages objectAtIndex:0]];
    double voiceSound = 0;
    voiceSound = [[YQHChatCDDeviceManager sharedInstance] emPeekRecorderVoiceMeter];
    int index = voiceSound*[_voiceMessageAnimationImages count];
    if (index >= [_voiceMessageAnimationImages count]) {
        _recordAnimationView.image = [UIImage imageNamed:[_voiceMessageAnimationImages lastObject]];
    } else {
        _recordAnimationView.image = [UIImage imageNamed:[_voiceMessageAnimationImages objectAtIndex:index]];
    }
    
}

@end
