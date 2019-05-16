//
//  YQHChatCDDeviceManager+ChatMedia.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHChatCDDeviceManager+ChatMedia.h"
#import "YQHChatAudioPlayerUtil.h"
#import "YQHChatVoiceConverter.h"
#import "YQHChatAudioRecorderUtil.h"

typedef NS_ENUM(NSInteger, EMAudioSession){
    EM_DEFAULT = 0,
    EM_AUDIOPLAYER,
    EM_AUDIORECORDER
};

#define EMErrorAudioRecordDurationTooShort -100
#define EMErrorFileTypeConvertionFailure -101
#define EMErrorAudioRecordStoping -102
#define EMErrorAudioRecordNotStarted -103

@implementation YQHChatCDDeviceManager (ChatMedia)

#pragma mark - AudioPlayer

+ (NSString*)dataPath
{
    NSString *dataPath = [NSString stringWithFormat:@"%@/Library/appdata/chatbuffer", NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dataPath]){
        [fm createDirectoryAtPath:dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }
    return dataPath;
}

// Play the audio
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{
    BOOL isNeedSetActive = YES;
    // Cancel if it is currently playing
    if([YQHChatAudioPlayerUtil isPlaying]){
        [YQHChatAudioPlayerUtil stopCurrentPlaying];
        isNeedSetActive = NO;
    }
    
    if (isNeedSetActive) {
        [self setupAudioSessionCategory:EM_AUDIOPLAYER
                               isActive:YES];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *wavFilePath = [[aFilePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"wav"];
    if ([YQHChatVoiceConverter isMP3File:aFilePath]) {
        wavFilePath = aFilePath;
    } else {
        if (![fileManager fileExistsAtPath:wavFilePath]) {
            BOOL covertRet = [self convertAMR:aFilePath toWAV:wavFilePath];
            if (!covertRet) {
                if (completon) {
                    completon([NSError errorWithDomain:@"文件格式转换失败"
                                                  code:EMErrorFileTypeConvertionFailure
                                              userInfo:nil]);
                }
                return ;
            }
        }
    }
    [YQHChatAudioPlayerUtil asyncPlayingWithPath:wavFilePath
                                 completion:^(NSError *error)
     {
         [self setupAudioSessionCategory:EM_DEFAULT
                                isActive:NO];
         if (completon) {
             completon(error);
         }
     }];
}

- (void)stopPlaying{
    [YQHChatAudioPlayerUtil stopCurrentPlaying];
    [self setupAudioSessionCategory:EM_DEFAULT
                           isActive:NO];
}

- (void)stopPlayingWithChangeCategory:(BOOL)isChange{
    [YQHChatAudioPlayerUtil stopCurrentPlaying];
    if (isChange) {
        [self setupAudioSessionCategory:EM_DEFAULT
                               isActive:NO];
    }
}

- (BOOL)isPlaying{
    return [YQHChatAudioPlayerUtil isPlaying];
}

#pragma mark - Recorder

+(NSTimeInterval)recordMinDuration{
    return 1.0;
}

// Start recording
- (void)asyncStartRecordingWithFileName:(NSString *)fileName
                             completion:(void(^)(NSError *error))completion{
    NSError *error = nil;
    
    if ([self isRecording]) {
        if (completion) {
            error = [NSError errorWithDomain:@"语音录制还没有结束"
                                        code:EMErrorAudioRecordStoping
                                    userInfo:nil];
            completion(error);
        }
        return ;
    }
    
    if (!fileName || [fileName length] == 0) {
        error = [NSError errorWithDomain:@"文件路径不存在"
                                    code:-1
                                userInfo:nil];
        completion(error);
        return ;
    }
    
    BOOL isNeedSetActive = YES;
    if ([self isRecording]) {
        [YQHChatAudioRecorderUtil cancelCurrentRecording];
        isNeedSetActive = NO;
    }
    
    [self setupAudioSessionCategory:EM_AUDIORECORDER
                           isActive:YES];
    
    _recorderStartDate = [NSDate date];
    
    NSString *recordPath = [NSString stringWithFormat:@"%@/%@", [YQHChatCDDeviceManager dataPath], fileName];
    [YQHChatAudioRecorderUtil asyncStartRecordingWithPreparePath:recordPath
                                                 completion:completion];
}

// Stop recording
-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath,
                                                 NSInteger aDuration,
                                                 NSError *error))completion{
    NSError *error = nil;
    
    if(![self isRecording]){
        if (completion) {
            error = [NSError errorWithDomain:@"还没有开始语音录制"
                                        code:EMErrorAudioRecordNotStarted
                                    userInfo:nil];
            completion(nil,0,error);
        }
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _recorderEndDate = [NSDate date];
    
    if([_recorderEndDate timeIntervalSinceDate:_recorderStartDate] < [YQHChatCDDeviceManager recordMinDuration]){
        if (completion) {
            error = [NSError errorWithDomain:@"录制时间过短"
                                        code:EMErrorAudioRecordDurationTooShort
                                    userInfo:nil];
            completion(nil,0,error);
        }
        
        // If the recording time is too shorty，in purpose delay one second
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([YQHChatCDDeviceManager recordMinDuration] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [YQHChatAudioRecorderUtil asyncStopRecordingWithCompletion:^(NSString *recordPath) {
                [weakSelf setupAudioSessionCategory:EM_DEFAULT isActive:NO];
            }];
        });
        return ;
    }
    
    [YQHChatAudioRecorderUtil asyncStopRecordingWithCompletion:^(NSString *recordPath) {
        if (completion) {
            if (recordPath) {
                // Convert wav to amr
                NSString *amrFilePath = [[recordPath stringByDeletingPathExtension]
                                         stringByAppendingPathExtension:@"amr"];
                BOOL convertResult = [self convertWAV:recordPath toAMR:amrFilePath];
                NSError *error = nil;
                if (convertResult) {
                    // Remove the wav
                    NSFileManager *fm = [NSFileManager defaultManager];
                    [fm removeItemAtPath:recordPath error:nil];
                }
                else {
                    error = [NSError errorWithDomain:@"文件格式转换失败"
                                                code:EMErrorFileTypeConvertionFailure
                                            userInfo:nil];
                }
                completion(amrFilePath,(int)[self->_recorderEndDate timeIntervalSinceDate:self->_recorderStartDate],error);
            }
            [weakSelf setupAudioSessionCategory:EM_DEFAULT isActive:NO];
        }
    }];
}

// Cancel recording
-(void)cancelCurrentRecording{
    [YQHChatAudioRecorderUtil cancelCurrentRecording];
    [self setupAudioSessionCategory:EM_DEFAULT isActive:NO];
}

-(BOOL)isRecording{
    return [YQHChatAudioRecorderUtil isRecording];
}

#pragma mark - Private
-(NSError *)setupAudioSessionCategory:(EMAudioSession)session
                             isActive:(BOOL)isActive{
    BOOL isNeedActive = NO;
    if (isActive != _currActive) {
        isNeedActive = YES;
        _currActive = isActive;
    }
    NSError *error = nil;
    NSString *audioSessionCategory = nil;
    switch (session) {
        case EM_AUDIOPLAYER:
            audioSessionCategory = AVAudioSessionCategoryPlayback;
            break;
        case EM_AUDIORECORDER:
            audioSessionCategory = AVAudioSessionCategoryRecord;
            break;
        default:
            audioSessionCategory = AVAudioSessionCategoryAmbient;
            break;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    if (![_currCategory isEqualToString:audioSessionCategory]) {
        [audioSession setCategory:audioSessionCategory error:nil];
    }
    if (isNeedActive) {
        BOOL success = [audioSession setActive:isActive
                                   withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                                         error:&error];
        if(!success || error){
            error = [NSError errorWithDomain:@"初始化AVAudioPlayer失败!"
                                        code:-1
                                    userInfo:nil];
            return error;
        }
    }
    _currCategory = audioSessionCategory;
    
    return error;
}

#pragma mark - Convert

- (BOOL)convertAMR:(NSString *)amrFilePath
             toWAV:(NSString *)wavFilePath
{
    BOOL ret = NO;
    BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:amrFilePath];
    if (isFileExists) {
        [YQHChatVoiceConverter amrToWav:amrFilePath wavSavePath:wavFilePath];
        isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:wavFilePath];
        if (isFileExists) {
            ret = YES;
        }
    }
    
    return ret;
}

- (BOOL)convertWAV:(NSString *)wavFilePath
             toAMR:(NSString *)amrFilePath {
    BOOL ret = NO;
    BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:wavFilePath];
    if (isFileExists) {
        [YQHChatVoiceConverter wavToAmr:wavFilePath amrSavePath:amrFilePath];
        isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:amrFilePath];
        if (!isFileExists) {
            
        } else {
            ret = YES;
        }
    }
    
    return ret;
}

@end
