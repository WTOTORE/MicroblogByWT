//
//  WTXMHomeFooterView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/21.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHomeFooterView.h"

@implementation WTXMHomeFooterView

+ (instancetype)footerView {
    
return [[[NSBundle mainBundle] loadNibNamed:@"WTXMHomeFooterView" owner:nil options:nil] firstObject];
}
@end
