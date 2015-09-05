//
//  UIView+WTXMIBInspectable.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "UIView+WTXMIBInspectable.h"

@implementation UIView (WTXMIBInspectable)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius=cornerRadius;
    self.layer.masksToBounds=YES;
}
- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth=borderWidth;
}
- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor=borderColor.CGColor;
}
- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
@end
