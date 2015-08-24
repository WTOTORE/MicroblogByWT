//
//  WTXMCellImageView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/24.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMCellImageView.h"
#import "WTXMStatusPhotosInfoModel.h"
@interface WTXMCellImageView ()
@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation WTXMCellImageView
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        //        self.contentMode=UIViewContentModeScaleToFill;
        self.contentMode = UIViewContentModeScaleAspectFill;
        //把超出部分剪掉
        self.clipsToBounds = YES;
        UIImageView *gifView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [gifView sizeToFit];
        [self addSubview:gifView];
        self.gifView=gifView;
    }
    return self;
}

- (void)setPhotoInfo:(WTXMStatusPhotosInfoModel *)photoInfo {
    _photoInfo=photoInfo;
    [self sd_setImageWithURL:[NSURL URLWithString:photoInfo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([photoInfo.thumbnail_pic hasSuffix:@".gif"]) {
        self.gifView.hidden=NO;
    }else {
        self.gifView.hidden=YES;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin=5;
    self.gifView.frame=CGRectMake(self.wid-self.gifView.wid-margin, self.hei-self.gifView.hei-margin,self.gifView.wid, self.gifView.hei);
    
}
@end
