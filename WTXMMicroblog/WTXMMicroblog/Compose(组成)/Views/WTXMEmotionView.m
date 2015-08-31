//
//  WTXMEmotionView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMEmotionView.h"

#import "WTXMEmotionButtonsView.h"
#import "WTXMEmotionsPageView.h"
@interface WTXMEmotionView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *emotionsView;
@property (nonatomic,weak) UIPageControl *pageCtrl;
@end

@implementation WTXMEmotionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        UIScrollView *emotionsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.wid, 153)];
        emotionsView.showsVerticalScrollIndicator = NO;
        emotionsView.showsHorizontalScrollIndicator = NO;
        emotionsView.pagingEnabled = YES;
        emotionsView.delegate = self;
        [self addSubview:emotionsView];
        self.emotionsView = emotionsView;
        UIPageControl *pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, emotionsView.hei, self.wid, 26)];
        [pageCtrl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageCtrl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [pageCtrl sizeThatFits:[UIImage imageNamed:@"compose_keyboard_dot_selected"].size];
        [self addSubview:pageCtrl];
        self.pageCtrl = pageCtrl;
        WTXMEmotionButtonsView *buttonsView = [[WTXMEmotionButtonsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pageCtrl.frame), self.wid, self.hei-pageCtrl.hei-emotionsView.hei)];
        [self addSubview:buttonsView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPagesInEmotionsView:) name:WTXMEmotionButtonDidClickedNotification object:nil];
    }
    return self;
}

- (void) addPagesInEmotionsView:(NSNotification *)noti {
   NSArray *emotions = noti.object;
    NSInteger count = emotions.count/20;
    NSInteger overCount = emotions.count%20;
    NSMutableArray *emotionsArr = [NSMutableArray array];
    if (overCount) {
        for (int i=0; i<count; i++) {
            NSArray *tempArr = [emotions subarrayWithRange:NSMakeRange(i*20, 20)];
            [emotionsArr addObject:tempArr];
        }
     NSArray *tempArr = [emotions subarrayWithRange:NSMakeRange(count*20, overCount)];
    [emotionsArr addObject:tempArr];
    }else {
        for (int i=0; i<count; i++) {
            NSArray *tempArr = [emotions subarrayWithRange:NSMakeRange(i*20, 20)];
            [emotionsArr addObject:tempArr];
        }
    }
    [self setPageViewsInEmotionsViewWithEmotions:emotionsArr];
}

- (void) setPageViewsInEmotionsViewWithEmotions:(NSArray *)emotions {
    for (UIView *view in self.emotionsView.subviews) {
        [view removeFromSuperview];
    }
    self.pageCtrl.numberOfPages = emotions.count;
    for (int i=0; i<emotions.count; i++) {
        
        NSArray *pageEmotions = emotions[i];
        WTXMEmotionsPageView *page = [[WTXMEmotionsPageView alloc] initWithFrame:self.emotionsView.bounds Emotions:pageEmotions];
        page.frame = CGRectMake(i*page.wid, 0, page.wid, page.hei);
        [self.emotionsView addSubview:page];
 
    }
    
    self.emotionsView.contentSize = CGSizeMake(self.emotionsView.wid*emotions.count, self.emotionsView.hei);
    self.emotionsView.contentOffset = CGPointMake(0, 0);
  }

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat page = scrollView.contentOffset.x/scrollView.wid;
    self.pageCtrl.currentPage = (int)(page+0.5);
    if (page>self.pageCtrl.numberOfPages+0.2) {
        
    }
}


@end
