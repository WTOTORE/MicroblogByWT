//
//  WTXMBlogModel.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMBlogModel.h"
#import "WTXMStatusPhotosInfoModel.h"
#define CURRENT_DATE [NSDate date]
@implementation WTXMBlogModel

- (NSString *)created_at {
  _created_at = @"Mon Aug 24 18:02:03 +0800 2014";
    NSDateFormatter *createdFormatter=[[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
//    //指定格式化的一个附加
//    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    createdFormatter.dateFormat=@"EEE MMM dd HH:mm:ss z yyyy";
    createdFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
    NSDate *createdDate=[createdFormatter dateFromString:_created_at];
    if ([self isThisYear:createdDate]) {
        
    }else {
        createdFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
        return [createdFormatter stringFromDate:createdDate];
    }
    
    
    
    
   
    
    return _created_at;
}
- (BOOL) isThisYear:(NSDate *)createdDate {
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    formater.dateFormat=@"yyyy";
    NSString *created=[formater stringFromDate:createdDate];
    NSString *current=[formater stringFromDate:CURRENT_DATE];
    return [created isEqualToString:current];
}










- (void)setSource:(NSString *)source {
    _source=source;
    NSRange preRange=[source rangeOfString:@"\">"];
    if (preRange.location!=NSNotFound) {
        NSInteger length=[source rangeOfString:@"</"].location-preRange.location-preRange.length;
        NSString *sourceStr=[source substringWithRange:NSMakeRange(preRange.location+preRange.length, length)];
        _source=[NSString stringWithFormat:@"来自 %@",sourceStr];
}
}

- (void)setReposts_count:(int)reposts_count {
    _reposts_count=reposts_count;
    if (reposts_count==0) {
        self.retweetCount=@"转发";
    }else {
        self.retweetCount=[self getButtonTitle:reposts_count];
    }
    
}
- (void)setComments_count:(int)comments_count {
    _comments_count=comments_count;
    if (comments_count==0) {
        self.commentCount=@"评论";
    }else {
        self. commentCount=[self getButtonTitle:comments_count];
    }
}
- (void)setAttitudes_count:(int)attitudes_count {
    _attitudes_count=attitudes_count;
    if (attitudes_count==0) {
        self.unlikeCount=@"赞一个";
    }else {
        self.unlikeCount=[self getButtonTitle:attitudes_count];
    }
}
- (NSString *)getButtonTitle:(int)count {
    if (count<10000) {
        return [NSString stringWithFormat:@"%d",count];
    }else {
        int result=count/1000;
        return [NSString stringWithFormat:@"%f万",result/10.0];
    }
}
+ (NSDictionary *)objectClassInArray {
    return @{@"pic_urls":[WTXMStatusPhotosInfoModel class]};
}
@end
