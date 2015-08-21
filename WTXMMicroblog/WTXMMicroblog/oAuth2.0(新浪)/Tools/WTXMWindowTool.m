//
//  WTXMWindowTool.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMWindowTool.h"
#import "WTXMAccountModel.h"
#import "WTXMAccountTool.h"
#import "AppDelegate.h"
#import "WTXMLoginSinaController.h"
#import "WTXMMainTabBarController.h"

@implementation WTXMWindowTool
+ (void)chooseRootViewController {
   WTXMAccountModel *account = [WTXMAccountTool account];
    if (account) {
         ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController=[WTXMMainTabBarController new];
    }else {
       
        ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController=[WTXMLoginSinaController new];
    }
}
@end
