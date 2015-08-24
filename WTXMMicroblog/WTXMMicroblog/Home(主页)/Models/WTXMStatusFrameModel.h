//
//  WTXMStatusFrameModel.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/21.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NAME_FONT 16
#define ADDR_FONT 14
#define TIME_FONT 14
#define TEXT_FONT 15
#define FORWARD_FONT 14
#define MARGIN 10
#define BUTTON_HEIGHT 36
#define SPACE_HEIGHT 10
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@class WTXMBlogModel;
@interface WTXMStatusFrameModel : NSObject
@property (nonatomic,strong) WTXMBlogModel *blog;

@property (nonatomic,assign) CGRect originateViewF;
@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect vipF;
@property (nonatomic,assign) CGRect timeF;
@property (nonatomic,assign) CGRect sourceF;
@property (nonatomic,assign) CGRect textF;
@property (nonatomic,assign) CGRect imageViewF;

@property (nonatomic,assign) CGRect retweetedViewF;
@property (nonatomic,assign) CGRect retweetTextF;
@property (nonatomic,assign) CGRect retweetImageViewF;

@property (nonatomic,assign) CGRect operateViewF;


@property (nonatomic,assign) CGFloat cellHeight;

@end
