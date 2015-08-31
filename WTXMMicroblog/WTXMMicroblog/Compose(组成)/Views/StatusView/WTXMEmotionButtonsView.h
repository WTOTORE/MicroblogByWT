//
//  WTXMEmotionButtonsView.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/30.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WTXMEmotionButtonDidClickedNotification @"WTXMEmotionButtonDidClickedNotification"
typedef NS_ENUM(NSUInteger, WTXMEmotionType) {
    WTXMEmotionTypeRecent,
    WTXMEmotionTypeDefault,
    WTXMEmotionTypeEmoji,
    WTXMEmotionTypeLxh
};
@interface WTXMEmotionButtonsView : UIView

@end
