//
//  NSDate+YQHChat.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/3/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NSDate+YQHChat.h"

@implementation NSDate (YQHChat)

/**
 * 计算指定时间与当前的时间差
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
- (NSString *)getFormatterTime:(long)time
{
//    NSDate* compareDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
//    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    NSString *result;
//    if (timeInterval <= 60) {
//        result = @"刚刚";
//    }else if (timeInterval <= 3600){//1小时内
//        timeInterval = timeInterval/60;
//        if (timeInterval<5) {
//            result = @"5分钟内";
//        }else if (timeInterval<30) {
//            result = @"30分钟内";
//        }else{
//            result = @"1小时内";
//        }
//    }else if (timeInterval <= 86400){//1天内
//        timeInterval = timeInterval/3600;
//        if (timeInterval<1) {
//            result = @"1小时内";
//        }else if (timeInterval<6) {
//            result = @"6小时内";
//        }else if (timeInterval<12) {
//            result = @"12小时内";
//        }else {
//            result = @"1天内";
//        }
//    }else if (timeInterval <= 604800){//7天内
//        timeInterval = timeInterval/(3600*24);
//        if (timeInterval<3) {
//            result = @"3天内";
//        }else if (timeInterval<2) {
//            result = @"2天内";
//        }else {
//            result = @"7天内";
//        }
//    }else{//大于7天 返回具体日期
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        result = [formatter stringFromDate:compareDate];
//    }
//    return  result;
    
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time] formattedTime];
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / 3600);
}

-(NSString *)formattedTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components];
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //If hasAMPM==TURE, use 12-hour clock, otherwise use 24-hour clock
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24-hour clock
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [self dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [self dateFormatterWithFormat:@"昨天HH:mm"];
        }else {
            dateFormatter = [self dateFormatterWithFormat:@"MM-dd HH:mm"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [self dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [self dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [self dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [self dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [self dateFormatterWithFormat:@"昨天HH:mm"];
        }else  {
            dateFormatter = [self dateFormatterWithFormat:@"MM月dd日 HH:mm"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

- (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

@end
