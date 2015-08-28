//
//  WTXMDateTool.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/25.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMDateTool.h"
#define CURRENT_DATE [NSDate date]
@implementation WTXMDateTool
+ (NSString *)formatDateWithDateString:(NSString *)dateString {
    NSDateFormatter *createdFormatter=[[NSDateFormatter alloc] init];
    //    formatter.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    //    //指定格式化的一个附加
    //    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    createdFormatter.dateFormat=@"EEE MMM dd HH:mm:ss z yyyy";
    createdFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate=[createdFormatter dateFromString:dateString];
    if ([self isThisYear:createdDate]) {
        if ([self isYesterday:createdDate]) {
            createdFormatter.dateFormat=@"HH:mm";
            NSString *date = [createdFormatter stringFromDate:createdDate];
            return [NSString stringWithFormat:@"昨天 %@",date];
        }else if([self isToday:createdDate]) {
            if ([self isInOneMinute:createdDate]) {
                return @"刚刚";
            }else if ([self isInOneHour:createdDate]) {
              NSTimeInterval sec = [CURRENT_DATE timeIntervalSinceDate:createdDate];
                NSInteger minute=sec/60;
                return [NSString stringWithFormat:@"%ld分钟前",(long)minute];
            }else {
                createdFormatter.dateFormat=@"HH:mm";
                NSString *date = [createdFormatter stringFromDate:createdDate];
                return [NSString stringWithFormat:@"今天 %@",date];
            }
            
        }else {
            createdFormatter.dateFormat=@"MM-dd HH:mm";
            return [createdFormatter stringFromDate:createdDate];
        }
    }else {
        createdFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
        return [createdFormatter stringFromDate:createdDate];
    }

  }
+ (BOOL) isThisYear:(NSDate *)createdDate {
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy";
    NSString *created=[formater stringFromDate:createdDate];
    NSString *current=[formater stringFromDate:CURRENT_DATE];
    return [created isEqualToString:current];
}
/**
 *  今年:   1.一分钟之内:刚刚
        2.一小时之内:几分钟前
        3.今天之内: 几时几分
        4.昨天: 昨天 几时几分
        5.前天及之前: 几月几日 几时几分
    不是今年:  年 月 日 时 分
 */
+ (BOOL)isYesterday:(NSDate *)createdDate {
     NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy MM dd";
    NSDate *currentDate=[CURRENT_DATE dateByAddingTimeInterval:-60*60*24];
    NSString *created=[formater stringFromDate:createdDate];
    NSString *current=[formater stringFromDate:currentDate];
    return [created isEqualToString:current];
}
+ (BOOL)isToday:(NSDate *)createdDate {
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy MM dd";
    NSString *created=[formater stringFromDate:createdDate];
    NSString *current=[formater stringFromDate:CURRENT_DATE];
    return [created isEqualToString:current];
}
+ (BOOL)isInOneMinute:(NSDate *)createdDate {
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy MM dd HH:mm:ss";
    NSDate *currentDate=[CURRENT_DATE dateByAddingTimeInterval:-60];
    NSString *created=[formater stringFromDate:createdDate];
    NSString *current=[formater stringFromDate:currentDate];
//    NSLog(@"%@-%@",created,current);
    return [created compare:current]==NSOrderedDescending;
}
+ (BOOL)isInOneHour:(NSDate *)createdDate {
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy MM dd HH:mm";
    NSDate *currentDate=[CURRENT_DATE dateByAddingTimeInterval:-60*60];
    NSString *created=[formater stringFromDate:createdDate];
    NSString *current=[formater stringFromDate:currentDate];
    return [created compare:current]==NSOrderedDescending;
}

@end
