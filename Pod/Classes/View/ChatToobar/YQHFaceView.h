//
//  YQHFaceView.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQHFacialView.h"
#import "YQHEmotionManager.h"

@protocol YQHFaceDelegate


@required
- (void)selectedFacialView:(NSString *)str isDelete:(BOOL)isDelete;
- (void)sendFace;
- (void)sendFaceWithEmotion:(YQHEmotion *)emotion;

@end

@interface YQHFaceView : UIView<YQHFacialViewDelegate>

@property (nonatomic, assign) id<YQHFaceDelegate> delegate;

- (BOOL)stringIsFace:(NSString *)string;

- (void)setEmotionManagers:(NSArray*)emotionManagers;

@end

