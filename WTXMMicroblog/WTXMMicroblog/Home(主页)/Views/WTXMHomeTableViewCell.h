//
//  WTXMHomeTableViewCell.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/21.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WTXMHomeTableViewCell_ID @"WTXMHomeTableViewCell"
@class WTXMStatusFrameModel;
@interface WTXMHomeTableViewCell : UITableViewCell
@property (nonatomic,strong) WTXMStatusFrameModel *statusFrame;

@end
