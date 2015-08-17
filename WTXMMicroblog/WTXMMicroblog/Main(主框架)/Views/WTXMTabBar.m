//
//  WTXMTabBar.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/13.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMTabBar.h"
@interface WTXMTabBar ()
@property (nonatomic,strong) UIButton *plusButton;

@end

@implementation WTXMTabBar
/**
 *  默认遵循系统父类代理的逻辑
 */
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    self.layer.contents=(__bridge id)([WTXMSkinImage skinImageNamed:@"tabbar_background"].CGImage);
    self.plusButton=[[UIButton alloc] init];
    [self.plusButton setBackgroundImage:[WTXMSkinImage skinImageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [self.plusButton setBackgroundImage:[WTXMSkinImage skinImageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [self.plusButton setImage:[WTXMSkinImage skinImageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [self.plusButton setImage:[WTXMSkinImage skinImageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    self.plusButton.size=self.plusButton.currentBackgroundImage.size;
    [self.plusButton addTarget:self action:@selector(modeTheComposeController:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.plusButton];
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.plusButton.centerX=self.frame.size.width*0.5;
    self.plusButton.centerY=self.frame.size.height*0.5;
    CGFloat itemW=self.frame.size.width*0.2;
    int index=0;
    for (int i=0; i<self.subviews.count; i++) {
        UIView *view=self.subviews[i];
//        [view isKindOfClass:[UITabBarButton class]]
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.wid=itemW;
            view.x=index*itemW;
            if (index==1) {
                index+=1;
            }
            index++;
        }
    }
}
- (void)modeTheComposeController:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectPlusButton:)]) {
        [self.delegate tabBar:self didSelectPlusButton:button];
    }
}
@end
