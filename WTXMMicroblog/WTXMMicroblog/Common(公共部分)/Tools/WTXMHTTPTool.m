//
//  WTXMHTTPTool.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/23.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHTTPTool.h"


@implementation WTXMHTTPTool
+ (void) getURLString:(NSString *) urlString Parameters:(NSDictionary *)parameters Class:(Class)clazz Success:(void(^)(id response))success Failure:(void(^)(NSError *error))failure {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id response) {
       id temp = [clazz objectWithKeyValues:response];
        if (success) {
            success(temp);
        }
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];

}
+ (void) postURLString:(NSString *) urlString Parameters:(NSDictionary *)parameters Class:(Class)clazz Success:(void(^)(id response))success Failure:(void(^)(NSError *error))failure {
    
}
    
@end
