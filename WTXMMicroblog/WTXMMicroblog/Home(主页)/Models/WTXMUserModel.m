//
//  WTXMUserModel.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMUserModel.h"

@implementation WTXMUserModel
- (void)setMbtype:(NSInteger)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype>=2;
}
@end
