//
//  WTXMCellImageView.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/24.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTXMStatusPhotosInfoModel;
@interface WTXMCellImageView : UIImageView
@property (nonatomic,strong) WTXMStatusPhotosInfoModel *photoInfo;
@end
