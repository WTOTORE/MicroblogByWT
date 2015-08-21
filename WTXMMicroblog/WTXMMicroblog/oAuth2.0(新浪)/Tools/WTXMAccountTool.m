//
//  WTXMAccountTool.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMAccountTool.h"
#import "WTXMAccountModel.h"
#define ACCOUNT_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation WTXMAccountTool
+ (void)saveAccount:(WTXMAccountModel *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_PATH];
}
/**
 *  判断账号是否过期
 *
 *  @return 过期和没有账号返回 nil
 */
+ (WTXMAccountModel *)account {
    WTXMAccountModel *account=[NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_PATH];
    NSDate *date=[account.loginDate dateByAddingTimeInterval:[account.expires_in integerValue]];
    NSDate *currentDate=[NSDate date];
    if ([currentDate compare:date]==NSOrderedDescending) {
        account=nil;
    }
    return account;
}



@end
