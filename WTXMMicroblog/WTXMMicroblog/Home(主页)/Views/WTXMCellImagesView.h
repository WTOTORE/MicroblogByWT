//
//  WTXMCellImagesView.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/24.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTXMCellImagesView : UIView<SDPhotoBrowserDelegate>
@property (nonatomic,assign) NSArray *imagePaths;
@property (nonatomic,assign) CGFloat imageViewHeight;
@property (nonatomic,strong) NSArray *images;
@end
