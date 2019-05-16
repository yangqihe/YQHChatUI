//
//  YQHChatAudioRecorderUtil.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatAudioRecorderUtil.h"

static YQHChatAudioRecorderUtil *audioRecorderUtil = nil;

@interface YQHChatAudioRecorderUtil () <AVAudioRecorderDelegate> {
    NSDate *_startDate;
    NSDate *_endDate;
    
    void (^recordFinish)(NSString *recordPath);
}
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSDictionary *recordSetting;

@end


@implementation YQHChatAudioRecorderUtil

#pragma mark - Public

+(BOOL)isRecording{
    return [[YQHChatAudioRecorderUtil sharedInstance] isRecording];
}

// Start recording
+ (void)asyncStartRecordingWithPreparePath:(NSString *)aFilePath
                                completion:(void(^)(NSError *error))completion{
    [[YQHChatAudioRecorderUtil sharedInstance] asyncStartRecordingWithPreparePath:aFilePath
                                                                  completion:completion];
}

// Stop recording
+(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath))completion{
    [[YQHChatAudioRecorderUtil sharedInstance] asyncStopRecordingWithCompletion:completion];
}

// Cancel recording
+(void)cancelCurrentRecording{
    [[YQHChatAudioRecorderUtil sharedInstance] cancelCurrentRecording];
}

+(AVAudioRecorder *)recorder{
    return [YQHChatAudioRecorderUtil sharedInstance].recorder;
}

#pragma mark - getter
- (NSDictionary *)recordSetting
{
    if (!_recordSetting) {
        _recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                          [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                          [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                          [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                          nil];
    }
    
    return _recordSetting;
}

#pragma mark - Private
+(YQHChatAudioRecorderUtil *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioRecorderUtil = [[self alloc] init];
    });
    
    return audioRecorderUtil;
}

-(instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

-(void)dealloc{
    if (_recorder) {
        _recorder.delegate = nil;
        [_recorder stop];
        [_recorder deleteRecording];
        _recorder = nil;
    }
    recordFinish = nil;
}

-(BOOL)isRecording{
    return !!_recorder;
}

// Start recording，save the audio file to the path
- (void)asyncStartRecordingWithPreparePath:(NSString *)aFilePath
                                completion:(void(^)(NSError *error))completion
{
    NSError *error = nil;
    NSString *wavFilePath = [[aFilePath stringByDeletingPathExtension]
                             stringByAppendingPathExtension:@"wav"];
    NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:wavFilePath];
    _recorder = [[AVAudioRecorder alloc] initWithURL:wavUrl
                                            settings:self.recordSetting
                                               error:&error];
    if(!_recorder || error)
    {
        _recorder = nil;
        if (completion) {
            error = [NSError errorWithDomain:@"文件格式转换失败"
                                        code:-1
                                    userInfo:nil];
            completion(error);
        }
        return ;
    }
    _startDate = [NSDate date];
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
    
    [_recorder record];
    if (completion) {
        completion(error);
    }
}

// Stop recording
-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath))completion{
    recordFinish = completion;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self->_recorder stop];
    });
}

// Cancel recording
- (void)cancelCurrentRecording
{
    _recorder.delegate = nil;
    if (_recorder.recording) {
        [_recorder stop];
    }
    _recorder = nil;
    recordFinish = nil;
}


#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                           successfully:(BOOL)flag
{
    NSString *recordPath = [[_recorder url] path];
    if (recordFinish) {
        if (!flag) {
            recordPath = nil;
        }
        recordFinish(recordPath);
    }
    _recorder = nil;
    recordFinish = nil;
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder
                                   error:(NSError *)error{
    NSLog(@"audioRecorderEncodeErrorDidOccur");
}

@end
