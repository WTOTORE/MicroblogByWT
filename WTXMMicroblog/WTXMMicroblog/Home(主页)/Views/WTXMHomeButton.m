//
//  WTXMHomeButton.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHomeButton.h"
#import "WTXMPopView.h"
@interface WTXMHomeButton ()
@property (nonatomic,weak) UIImageView *bgView;

@end

@implementation WTXMHomeButton
- (instancetype)init {
    if (self=[super init]) {
        [self setTitle:@"首页" forState: UIControlStateNormal];
        [self setImage:[WTXMSkinImage skinImageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[WTXMSkinImage skinImageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self sizeToFit];
        [self addTarget:self action:@selector(homeTitleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

/**
 *  首页标题按钮的点击事件
 *
 *  @param button 标题按钮
 */
- (void)homeTitleButtonClicked:(UIButton *)button {
    if (button.selected) {
        button.selected=NO;
    }else {
        button.selected=YES;
    }
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(5, 12, 100, 100)];
    view.backgroundColor=[UIColor redColor];
    WTXMPopView *pop=[[WTXMPopView alloc] initWithCustomView:view];
    [pop showWithTargetView:button];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.x=0;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+5;
    self.wid=CGRectGetMaxX(self.imageView.frame);
    self.centerX=self.superview.wid*0.5;
}
- (void) setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void) setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
