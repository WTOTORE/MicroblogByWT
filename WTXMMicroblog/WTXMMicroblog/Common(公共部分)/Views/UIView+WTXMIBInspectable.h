//
//  UIView+WTXMIBInspectable.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//
#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface UIView (WTXMIBInspectable)

@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;
@property (nonatomic,strong) IBInspectable UIColor *borderColor;

@end
