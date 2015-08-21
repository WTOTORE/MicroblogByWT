//
//  WTXMStatusFrameModel.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/21.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WTXMBlogModel;
@interface WTXMStatusFrameModel : NSObject
@property (nonatomic,strong) WTXMBlogModel *blog;
@property (nonatomic,assign) CGFloat originateViewHeight;
@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect vipF;
@property (nonatomic,assign) CGRect timeF;
@property (nonatomic,assign) CGRect addressF;
@property (nonatomic,assign) CGRect textF;
@property (nonatomic,assign) CGRect imageViewF;
@property (nonatomic,assign) CGFloat forwardViewHeight;
@property (nonatomic,assign) CGFloat operateViewHeight;
@property (nonatomic,assign) CGFloat cellHeight;

@end
