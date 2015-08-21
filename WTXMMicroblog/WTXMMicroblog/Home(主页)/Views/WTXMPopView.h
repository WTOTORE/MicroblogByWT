//
//  WTXMPopView.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/18.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTXMPopView : UIButton
@property (nonatomic,copy) void (^buttonClicked)();
- (instancetype) initWithCustomView:(UIView *)customView;
- (void)showWithTargetView:(UIView *)targetView;
@end
