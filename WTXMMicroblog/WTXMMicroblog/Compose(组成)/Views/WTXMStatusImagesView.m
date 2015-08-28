//
//  WTXMStatusImagesView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMStatusImagesView.h"
#import "WTXMStatusPhoto.h"

@implementation WTXMStatusImagesView

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    int maxCol = 3;
    CGFloat margin = 10;
    CGFloat imgWH = (self.wid-4*margin)/maxCol;
    for (int i=0; i<count; i++) {
        int col = i%maxCol;
        int row = i/maxCol;
        WTXMStatusPhoto *imgView = self.subviews[i];
        if (!(imgView.x==margin&&imgView.y==0)) {
            [UIView animateWithDuration:0.25 animations:^{
                imgView.frame = CGRectMake(margin+(margin+imgWH)*col, (margin+imgWH)*row, imgWH, imgWH);
            }];
        }else {
        imgView.frame = CGRectMake(margin+(margin+imgWH)*col, (margin+imgWH)*row, imgWH, imgWH);
        }
        self.hei = CGRectGetMaxY(imgView.frame);
    }

}
- (void) addImage:(UIImage *)image {
    WTXMStatusPhoto *img = [[WTXMStatusPhoto alloc] initWithImage:image];
    [self addSubview:img];
}
@end
