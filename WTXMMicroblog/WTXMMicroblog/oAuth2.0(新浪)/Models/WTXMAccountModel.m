//
//  WTXMAccountModel.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMAccountModel.h"

@implementation WTXMAccountModel
- (void)setAccess_token:(NSString *)access_token {
    _access_token=access_token;
    self.loginDate=[NSDate date];
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
}
/**
 *  uid = 1792677813;
	expires_in = 157679999;
	access_token = 2.00R5t_xBORLuxC4f744c1c991CM4yB;
	remind_in = 157679999;
 */
- (instancetype) initWithCoder:(NSCoder *)decoder {
    self=[super init];
    if (self) {
        self.access_token=[decoder decodeObjectForKey:@"access_token"];
        self.uid=[decoder decodeObjectForKey:@"uid"];
        self.expires_in=[decoder decodeObjectForKey:@"expires_in"];
        self.remind_in=[decoder decodeObjectForKey:@"remind_in"];
    }
    return self;
}
@end
