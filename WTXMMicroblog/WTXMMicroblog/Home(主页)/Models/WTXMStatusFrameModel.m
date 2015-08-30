//
//  WTXMStatusFrameModel.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/21.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMStatusFrameModel.h"
#import "WTXMUserModel.h"
#import "WTXMBlogModel.h"
#import "WTXMGeoModel.h"
#import "WTXMCellImagesView.h"

@implementation WTXMStatusFrameModel
- (void)setBlog:(WTXMBlogModel *)blog {
    _blog=blog;
    [self setOriginalViewFrame:blog];
    [self setRetweetViewFrame:blog.retweeted_status];
//    self.operateViewF=CGRectMake(0, CGRectGetMaxY(self.retweetedViewF),  SCREEN_WIDTH, BUTTON_HEIGHT);
    self.operateViewF=CGRectMake(0, self.originateViewF.size.height+self.retweetedViewF.size.height,  SCREEN_WIDTH, BUTTON_HEIGHT);
    self.cellHeight=CGRectGetMaxY(self.operateViewF)+SPACE_HEIGHT;
    }

/**
 *  字数少的 label 的 size
 */
- (CGSize) getLabelSizeWithText:(NSString *)text FontSize:(CGFloat)font{
    UILabel *lab=[[UILabel alloc] init];
    lab.text=text;
    lab.font=[UIFont systemFontOfSize:font];
    [lab sizeToFit];
    return lab.size;
}
/**
 *   微博正文的 label size
 *
 */
- (CGSize)getTextLabelWithText:(NSString *)text FontSize:(CGFloat)font {
    UILabel *lab=[UILabel new];
    lab.numberOfLines=0;
    lab.font=[UIFont systemFontOfSize:font];
    CGSize textLabelSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-2*MARGIN, MAXFLOAT);
    lab.text=text;
    return [lab sizeThatFits:textLabelSize];
}
/**
 *   设置原创微博的 frame
 */
- (void) setOriginalViewFrame:(WTXMBlogModel *)blog {
    
    self.iconF=CGRectMake(MARGIN, MARGIN, 50, 50);
    
    CGSize nameSize=[self getLabelSizeWithText:blog.user.screen_name FontSize:NAME_FONT];
    self.nameF=CGRectMake(CGRectGetMaxX(self.iconF)+MARGIN, MARGIN, nameSize.width, nameSize.height);
    
    UIImageView *vip=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership_level3"]];
    [vip sizeToFit];
    self.vipF=CGRectMake(CGRectGetMaxX(self.nameF)+MARGIN, MARGIN, vip.wid, vip.hei);
    
    
    CGSize timeSize=[self getLabelSizeWithText:blog.created_at FontSize:TIME_FONT];
    self.timeF=CGRectMake(CGRectGetMaxX(self.iconF)+MARGIN, CGRectGetMaxY(self.nameF)+MARGIN, timeSize.width, timeSize.height);
    
    
    CGSize sourceSize=[self getLabelSizeWithText:blog.source FontSize:ADDR_FONT];
    self.sourceF=CGRectMake(CGRectGetMaxX(self.timeF)+MARGIN, CGRectGetMaxY(self.nameF)+MARGIN, sourceSize.width, sourceSize.height);
    
    CGSize textSize=[self getTextLabelWithText:blog.text FontSize:TEXT_FONT];
    CGFloat maxY=CGRectGetMaxY(self.iconF)>CGRectGetMaxY(self.timeF)?CGRectGetMaxY(self.iconF):CGRectGetMaxY(self.timeF);
    self.textF=CGRectMake(MARGIN, maxY+MARGIN, textSize.width, textSize.height);
    
    WTXMCellImagesView *imgView=[[WTXMCellImagesView alloc] init];
    imgView.imagePaths=blog.pic_urls;
    if (imgView.imagePaths) {
        self.imageViewF=CGRectMake(0, CGRectGetMaxY(self.textF),[UIScreen mainScreen].bounds.size.width,imgView.imageViewHeight);
    }else {
        self.imageViewF=CGRectZero;
    }
   self.originateViewF=CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.textF)+imgView.imageViewHeight+MARGIN);
}

- (void) setRetweetViewFrame:(WTXMBlogModel *)retweetBlog {
    if (!retweetBlog) {
        self.retweetedViewF=CGRectZero;
        return;
    }
    CGSize textSize=[self getTextLabelWithText:retweetBlog.text FontSize:TEXT_FONT];
    self.retweetTextF=CGRectMake(MARGIN, MARGIN, textSize.width, textSize.height);
    
    WTXMCellImagesView *imgView=[[WTXMCellImagesView alloc] init];
    imgView.imagePaths=retweetBlog.pic_urls;
    if (imgView.imagePaths) {
        self.retweetImageViewF=CGRectMake(0, CGRectGetMaxY(self.retweetTextF),[UIScreen mainScreen].bounds.size.width,imgView.imageViewHeight);
    }else {
        self.retweetImageViewF=CGRectZero;
    }
   
    
    self.retweetedViewF=CGRectMake(0, self.originateViewF.size.height, SCREEN_WIDTH, self.retweetTextF.size.height+MARGIN+imgView.imageViewHeight+MARGIN);
}



@end
