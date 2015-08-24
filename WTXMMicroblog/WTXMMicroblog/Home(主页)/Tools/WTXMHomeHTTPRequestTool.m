//
//  WTXMHomeHTTPRequestTool.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/23.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHomeHTTPRequestTool.h"
#import "WTXMStatusesModel.h"
#import "WTXMBlogModel.h"
#import "WTXMStatusFrameModel.h"
#import "WTXMUserModel.h"
#import "WTXMUnreadCountModel.h"


@implementation WTXMHomeHTTPRequestTool
+ (void) loadNewStatusesWithModelArray:(NSMutableArray *)modelArrays RefreshControl:(UIRefreshControl *)refreshControl Success:(void(^)(id ))success Failure:(void(^)(NSError *))failure{
    NSString *urlStr=@"https://api.weibo.com/2/statuses/home_timeline.json";
    WTXMAccountModel *account=[WTXMAccountTool account];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    //    parameters[@"count"]=@1;//默认为20
    parameters[@"since_id"]=@([[[modelArrays firstObject] blog] id]);//此处是 since_id 和 statuses 字典里面的 id 作比较,而不是 since_id
    [WTXMHTTPTool getURLString:urlStr Parameters:parameters Class:[WTXMStatusesModel class] Success:^(WTXMStatusesModel *response) {
        [refreshControl endRefreshing];
        
        NSArray *blogArr=[WTXMBlogModel objectArrayWithKeyValuesArray:response.statuses];
        NSMutableArray *tempArr=[NSMutableArray array];
        for (WTXMBlogModel *blog in blogArr) {
            WTXMStatusFrameModel *statusFrame=[[WTXMStatusFrameModel alloc] init];
            statusFrame.blog=blog;
            [tempArr addObject:statusFrame];
        }
        blogArr=tempArr;
        
        if (success) {
            success(blogArr);
        }
       
        
    } Failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+ (void)loadOldStatusesWithModelArray:(NSMutableArray *)modelArrays RefreshControl:(UIRefreshControl *)refreshControl Success:(void (^)(id))success Failure:(void (^)(NSError *))failure {
    NSString *urlStr=@"https://api.weibo.com/2/statuses/home_timeline.json";
    WTXMAccountModel *account=[WTXMAccountTool account];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    //    parameters[@"count"]=@1;//默认为20
    parameters[@"max_id"]=@([[[modelArrays lastObject] blog] id]-1);//此处是 since_id 和 statuses 字典里面的 id 作比较,而不是 since_id
    [WTXMHTTPTool getURLString:urlStr Parameters:parameters Class:[WTXMStatusesModel class] Success:^(WTXMStatusesModel *response) {
        [refreshControl endRefreshing];
        
        NSArray *blogArr=[WTXMBlogModel objectArrayWithKeyValuesArray:response.statuses];
        NSMutableArray *tempArr=[NSMutableArray array];
        for (WTXMBlogModel *blog in blogArr) {
            WTXMStatusFrameModel *statusFrame=[[WTXMStatusFrameModel alloc] init];
            statusFrame.blog=blog;
            [tempArr addObject:statusFrame];
        }
        blogArr=tempArr;
        [modelArrays addObjectsFromArray:blogArr];
        if (success) {
            success(modelArrays);
        }
        
        
    } Failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+ (void)getUserInfoSuccess:(void (^)(WTXMUserModel *))success Failure:(void (^)(NSError *))failure {
    WTXMAccountModel *account=[WTXMAccountTool account];
    
    NSString *urlStr=@"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    parameters[@"uid"]=account.uid;
    [WTXMHTTPTool getURLString:urlStr Parameters:parameters Class:[WTXMUserModel class] Success:^(id response) {
        [[NSUserDefaults standardUserDefaults] setObject:[response screen_name] forKey:@"_user.name"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (success) {
            success(response);
        }

    } Failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getUnreadStatusCountSuccess:(void (^)(WTXMUnreadCountModel *))success Failure:(void (^)(NSError *))failure {
    NSString *urlStr=@"https://rm.api.weibo.com/2/remind/unread_count.json";
    WTXMAccountModel *account=[WTXMAccountTool account];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    /**
     *
     必选	类型及范围	说明
     source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
     
     */
    parameters[@"access_token"]=account.access_token;
    parameters[@"uid"]=account.uid;
[WTXMHTTPTool getURLString:urlStr Parameters:parameters Class:[WTXMUnreadCountModel class] Success:^(id response) {
    if (success) {
        success(response);
    }
} Failure:^(NSError *error) {
    
}];

}
@end
