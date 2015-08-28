//
//  WTXMComposeButton.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/26.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, WTXMComposeButtonType) {
    WTXMComposeButtonTypeUp,
    WTXMComposeButtonTypeDown,
};
@interface WTXMComposeButton : UIButton
- (void) performAnimationWithBeginTime:(CFTimeInterval) time Type:(WTXMComposeButtonType)type;
@end
