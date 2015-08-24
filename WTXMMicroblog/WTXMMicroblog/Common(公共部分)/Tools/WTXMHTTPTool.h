//
//  WTXMHTTPTool.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/23.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTXMHTTPTool : NSObject
//[manager GET:urlStr parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id response)
+ (void) getURLString:(NSString *) urlString Parameters:(NSDictionary *)parameters Class:(Class)clazz Success:(void(^)(id response))success Failure:(void(^)(NSError *error))failure;
+ (void) postURLString:(NSString *) urlString Parameters:(NSDictionary *)parameters Class:(Class)clazz Success:(void(^)(id response))success Failure:(void(^)(NSError *error))failure;
@end
