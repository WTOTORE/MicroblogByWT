//
//  WTXMComposeButton.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/26.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMComposeButton.h"

@implementation WTXMComposeButton
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
   
    CGFloat imgW=71;
    CGFloat imgH=71;
    CGFloat imgX=(contentRect.size.width-imgW)*0.5;
    CGFloat imgY=0;
    CGRect imgRect=CGRectMake(imgX, imgY, imgW, imgH);
    return imgRect;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW=contentRect.size.width;
    CGFloat titleH=contentRect.size.height-72;
    CGFloat titleX=0;
    CGFloat titleY=72;
    CGRect titleRect=CGRectMake(titleX, titleY, titleW, titleH);
    return titleRect;
}

- (void) performAnimationWithBeginTime:(CFTimeInterval) time Type:(WTXMComposeButtonType)type {
    POPSpringAnimation *animation=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat margin = -350;
    if (type==WTXMComposeButtonTypeDown) {
        margin=350;
    }
    animation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.centerX,self.centerY+margin)];
    animation.springSpeed=20;
    animation.springBounciness=12;
    animation.beginTime=CACurrentMediaTime()+time;
    [self pop_addAnimation:animation forKey:nil];
}

@end
