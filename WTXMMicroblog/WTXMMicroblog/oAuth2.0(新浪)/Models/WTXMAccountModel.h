//
//  WTXMAccountModel.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  uid = 1792677813;
	expires_in = 157679999;
	access_token = 2.00R5t_xBORLuxC4f744c1c991CM4yB;
	remind_in = 157679999;
 */
@interface WTXMAccountModel : NSObject<NSCoding>
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *expires_in;
@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *remind_in;

@property (nonatomic,strong) NSDate *loginDate;
@end
