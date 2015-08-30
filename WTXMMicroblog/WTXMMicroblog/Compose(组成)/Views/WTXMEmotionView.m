//
//  WTXMEmotionView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMEmotionView.h"
#import "WTXMEmotionPageView.h"
#import "WTXMEmotionButtonsView.h"

@implementation WTXMEmotionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        WTXMEmotionPageView *pageView = [[WTXMEmotionPageView alloc] initWithFrame:CGRectMake(0, 0, self.wid, 138)];
        [self addSubview:pageView];
        UIPageControl *pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageView.hei, self.wid, 25)];
        pageCtrl.backgroundColor = [UIColor whiteColor];
        [self addSubview:pageCtrl];
        WTXMEmotionButtonsView *buttonsView = [[WTXMEmotionButtonsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pageCtrl.frame), self.wid, self.hei-pageCtrl.hei-pageView.hei)];
        [self addSubview:buttonsView];
    }
    return self;
}









@end
