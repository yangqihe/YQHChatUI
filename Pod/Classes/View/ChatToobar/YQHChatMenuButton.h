//
//  YQHChatMenuButton.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/27.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQHChatMenuButton : UIView

typedef void (^YQHChatMenuButtonBlock)(void);

-(instancetype)initWithFrame:(CGRect)frame withImage:(UIImage*)image withHightImage:(UIImage*)hightImage withText:(NSString*)text withClickBlock:(YQHChatMenuButtonBlock)block;

@end

