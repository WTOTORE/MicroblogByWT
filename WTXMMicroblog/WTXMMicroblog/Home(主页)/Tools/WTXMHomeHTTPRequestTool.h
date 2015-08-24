//
//  WTXMHomeHTTPRequestTool.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/23.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WTXMUserModel,WTXMUnreadCountModel;
@interface WTXMHomeHTTPRequestTool : NSObject
+ (void) loadNewStatusesWithModelArray:(NSMutableArray *)modelArrays RefreshControl:(UIRefreshControl *)refreshControl Success:(void(^)(id array))success Failure:(void(^)(NSError *error))failure;
+ (void) loadOldStatusesWithModelArray:(NSMutableArray *)modelArrays RefreshControl:(UIRefreshControl *)refreshControl Success:(void(^)(id array))success Failure:(void(^)(NSError *error))failure;
+ (void)getUserInfoSuccess:(void (^)(WTXMUserModel *user))success Failure:(void (^)(NSError *error))failure;
+(void)getUnreadStatusCountSuccess:(void (^)(WTXMUnreadCountModel *unreadCount))success Failure:(void (^)(NSError *error))failure;
@end
