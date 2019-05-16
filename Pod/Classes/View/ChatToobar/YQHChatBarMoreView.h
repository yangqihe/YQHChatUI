//
//  YQHChatBarMoreView.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YQHChatToolbarTypeChat,
    YQHChatToolbarTypeGroup,
}YQHChatToolbarType;

@protocol YQHChatBarMoreViewDelegate;

@interface YQHChatBarMoreView : UIView

@property (nonatomic,assign) id<YQHChatBarMoreViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame type:(YQHChatToolbarType)type;

@end

@protocol YQHChatBarMoreViewDelegate <NSObject>

@optional

- (void)moreViewTakePicAction:(YQHChatBarMoreView *)moreView;
- (void)moreViewPhotoAction:(YQHChatBarMoreView *)moreView;
- (void)moreViewVideoAction:(YQHChatBarMoreView *)moreView;

- (void)moreViewLocationAction:(YQHChatBarMoreView *)moreView;
- (void)moreViewAudioCallAction:(YQHChatBarMoreView *)moreView;
- (void)moreViewVideoCallAction:(YQHChatBarMoreView *)moreView;
- (void)moreView:(YQHChatBarMoreView *)moreView didItemInMoreViewAtIndex:(NSInteger)index;

@end


//@property (nonatomic) UIColor *moreViewBackgroundColor UI_APPEARANCE_SELECTOR;  //moreview背景颜色,default whiteColor

//- (void)insertItemWithImage:(UIImage*)image
//           highlightedImage:(UIImage*)highLightedImage
//                      title:(NSString*)title;
//
//- (void)updateItemWithImage:(UIImage*)image
//           highlightedImage:(UIImage*)highLightedImage
//                      title:(NSString*)title
//                    atIndex:(NSInteger)index;
//
//- (void)removeItematIndex:(NSInteger)index;
