//
//  WTXMCellImagesView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/24.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMCellImagesView.h"
#import "WTXMStatusPhotosInfoModel.h"
#import "WTXMCellImageView.h"

@implementation WTXMCellImagesView

- (NSArray *)images {
    if (!_images) {
        NSMutableArray *tempArr=[NSMutableArray array];
        for (int i=0; i<9; i++) {
        WTXMCellImageView *img=[[WTXMCellImageView alloc] init];
            [tempArr addObject:img];
        }
        _images=tempArr;
    }
    return _images;
}
- (void)setImagePaths:(NSArray *)imagePaths {
    for (WTXMCellImageView *view in self.images) {
        view.hidden=YES;
    }
    _imagePaths = imagePaths;
    CGFloat space=8.0;
    NSInteger imageCol=3;
    CGFloat imageWH=([UIScreen mainScreen].bounds.size.width-4*space)/imageCol;
    
    if (imagePaths.count==4) {
        imageCol=2;
    }
    for (int i=0; i<imagePaths.count; i++) {
        WTXMCellImageView *img=self.images[i];
        img.tag=i;
        img.hidden=NO;
        img.photoInfo=imagePaths[i];
        int row=i/imageCol;
        int col=i%imageCol;
        img.frame=CGRectMake(space+col*(imageWH+space),(imageWH+space)*row, imageWH, imageWH);
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [img addGestureRecognizer:recognizer];
        [self addSubview:img];
        self.imageViewHeight=CGRectGetMaxY(img.frame);
    }

    
}
- (void)imageTap:(UITapGestureRecognizer *)recognizer {
    UIView *view=recognizer.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = self;
    
    browser.imageCount = self.imagePaths.count;
    
    browser.currentImageIndex = view.tag;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return [[self.subviews objectAtIndex:index] image];
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    WTXMStatusPhotosInfoModel *photoInfo=self.imagePaths[index];
    NSString *urlStr=[photoInfo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}
@end
