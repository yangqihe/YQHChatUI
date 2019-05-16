//
//  YQHRecordView.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YQHRecordViewTypeTouchDown,
    YQHRecordViewTypeTouchUpInside,
    YQHRecordViewTypeTouchUpOutside,
    YQHRecordViewTypeDragInside,
    YQHRecordViewTypeDragOutside,
}YQHRecordViewType;

@interface YQHRecordView : UIView

@property (nonatomic) NSArray *voiceMessageAnimationImages UI_APPEARANCE_SELECTOR;

@property (nonatomic) NSString *upCancelText UI_APPEARANCE_SELECTOR;

@property (nonatomic) NSString *loosenCancelText UI_APPEARANCE_SELECTOR;

-(void)recordButtonTouchDown;
-(void)recordButtonTouchUpInside;
-(void)recordButtonTouchUpOutside;
-(void)recordButtonDragInside;
-(void)recordButtonDragOutside;

@end
