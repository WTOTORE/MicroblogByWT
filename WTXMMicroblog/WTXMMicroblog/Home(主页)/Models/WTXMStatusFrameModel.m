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

@implementation WTXMStatusFrameModel
- (void)setBlog:(WTXMBlogModel *)blog {
    _blog=blog;
    [self setOriginalViewFrame:blog];
    }
- (CGSize) getLabelSizeWithText:(NSString *)text FontSize:(CGFloat)font{
    UILabel *lab=[[UILabel alloc] init];
    lab.text=text;
    lab.font=[UIFont systemFontOfSize:font];
    [lab sizeToFit];
    return lab.size;
}
- (void) setOriginalViewFrame:(WTXMBlogModel *)blog {
    CGFloat margin=10;
    self.iconF=CGRectMake(margin, margin, 50, 50);
    CGSize nameSize=[self getLabelSizeWithText:blog.user.screen_name FontSize:16];
    self.nameF=CGRectMake(CGRectGetMaxX(self.iconF)+margin, margin, nameSize.width, nameSize.height);
    CGSize timeSize=[self getLabelSizeWithText:blog.created_at FontSize:14];
    self.timeF=CGRectMake(CGRectGetMaxX(self.iconF)+margin, CGRectGetMaxY(self.nameF)+margin, timeSize.width, timeSize.height);
    CGSize textSize=[self getLabelSizeWithText:blog.text FontSize:15];
    CGFloat maxY=CGRectGetMaxY(self.iconF)>CGRectGetMaxY(self.timeF)?CGRectGetMaxY(self.iconF):CGRectGetMaxY(self.timeF);
    self.textF=CGRectMake(margin, maxY+margin, textSize.width, textSize.height);
    self.originateViewHeight=CGRectGetMaxY(self.textF)+margin;
}
@end
