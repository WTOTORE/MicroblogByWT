//
//  WTXMPopView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/18.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMPopView.h"
@interface WTXMPopView ()
@property (nonatomic,weak) UIImageView *bgView;

@end

@implementation WTXMPopView
- (instancetype)initWithCustomView:(UIView *)customView {
    self= [super init];
    self.size=[UIScreen mainScreen].bounds.size;
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imgView=[[UIImageView alloc] init];
        imgView.image=[UIImage imageNamed:@"popover_background"] ;
        imgView.size=CGSizeMake(customView.wid+10, customView.hei+20);
        customView.center=imgView.center;
        customView.centerY+=2;
        [imgView addSubview:customView];
        [self addSubview:imgView];
        self.bgView=imgView;
    }

    return self;
}
- (void)showWithTargetView:(UIView *)targetView {
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    CGRect rect=[targetView convertRect:targetView.bounds toView:window];
    self.bgView.centerX=CGRectGetMidX(rect);
    self.bgView.y=CGRectGetMaxY(rect);
    [window addSubview:self];
}
- (void) hide:(UIButton *)button {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
