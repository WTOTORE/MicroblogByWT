//
//  WTXMStatusPhoto.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMStatusPhoto.h"
@interface WTXMStatusPhoto ()
@property (nonatomic,weak) UIButton *deleteButton;

@end

@implementation WTXMStatusPhoto

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
        UIButton *delBtn = [[UIButton alloc] init];
        [delBtn setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        [delBtn sizeToFit];
        [self addSubview:delBtn];
        self.deleteButton=delBtn;
        [delBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    

}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.deleteButton.frame = CGRectMake(self.frame.size.width-self.deleteButton.wid, 0, self.deleteButton.wid, self.deleteButton.hei);

}



- (void) deleteImage:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha=0.1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25 animations:^{
                [self removeFromSuperview];

            }];
        }
            }];
    
}

@end
