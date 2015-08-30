//
//  WTXMStatusTextView.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ToolButtonRelated) {
    ToolButtonRelatedCamera,
    ToolButtonRelatedPhotos,
    ToolButtonRelatedUsers,
    ToolButtonRelatedTrend,
    ToolButtonRelatedEmotion
};
@class WTXMStatusImagesView;
@interface WTXMStatusTextView : UITextView
@property (nonatomic,copy) void (^toolButtonClick) (UIButton *);
@property (nonatomic,strong) WTXMStatusImagesView *imagesView;
- (void) showEmotionView;
- (void) hideEmotionView;
@end
