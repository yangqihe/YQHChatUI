//
//  YQHFacialView.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQHEmotion;
@protocol YQHFacialViewDelegate

@optional
-(void)selectedFacialView:(NSString*)str;
-(void)deleteSelected:(NSString *)str;
-(void)sendFace;
-(void)sendFace:(YQHEmotion *)emotion;

@end

@class YQHEmotionManager;

@interface YQHFacialView : UIView
{
    NSMutableArray *_faces;
}

@property(nonatomic, weak) id<YQHFacialViewDelegate> delegate;

@property(strong, nonatomic, readonly) NSArray *faces;

-(void)loadFacialView:(NSArray*)emotionManagers size:(CGSize)size;

-(void)loadFacialViewWithPage:(NSInteger)page;

@end

