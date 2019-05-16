//
//  YQHMessageTimeCell.h
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQHMessageTimeCell : UITableViewCell

@property (strong, nonatomic) NSString *title;

@property (nonatomic) UIFont *titleLabelFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:12]

@property (nonatomic) UIColor *titleLabelColor UI_APPEARANCE_SELECTOR; //default [UIColor grayColor]

+ (NSString *)cellIdentifier;

@end

