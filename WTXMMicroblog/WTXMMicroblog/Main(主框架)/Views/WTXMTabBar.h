//
//  WTXMTabBar.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/13.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTXMTabBar;
@protocol WTXMTabBarDelegate <NSObject,UITabBarDelegate>

@optional
- (void)tabBar:(WTXMTabBar *)tabBar didSelectPlusButton:(UIButton *)button;

@end
@interface WTXMTabBar : UITabBar

@property (nonatomic,weak) id<WTXMTabBarDelegate> delegate;
@end
