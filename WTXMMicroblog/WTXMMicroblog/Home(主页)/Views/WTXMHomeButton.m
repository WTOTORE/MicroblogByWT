//
//  WTXMHomeButton.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHomeButton.h"

@implementation WTXMHomeButton
- (instancetype)init {
    if (self=[super init]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
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
