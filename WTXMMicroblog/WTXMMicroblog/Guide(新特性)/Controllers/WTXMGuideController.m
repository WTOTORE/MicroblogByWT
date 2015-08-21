//
//  WTXMGuideController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/18.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMGuideController.h"
#import "AppDelegate.h"
#define kCount 4
@interface WTXMGuideController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageCtrl;
@end

@implementation WTXMGuideController
- (instancetype)init {
    self=[super init];
    if (self) {
        UIPageControl *pageCtrl=[[UIPageControl alloc] init];
        pageCtrl.numberOfPages=kCount;
        pageCtrl.currentPageIndicatorTintColor=[UIColor orangeColor];
        pageCtrl.pageIndicatorTintColor=[UIColor lightGrayColor];
        pageCtrl.center=self.view.center;
        pageCtrl.centerY=self.view.hei-50;
        
        UIScrollView *guideView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
        guideView.pagingEnabled=YES;
        guideView.showsHorizontalScrollIndicator=NO;
        guideView.delegate=self;
        CGSize size=guideView.size;
        for (int i=0; i<kCount; i++) {
            UIImageView *imageView=[[UIImageView alloc] init];
            imageView.userInteractionEnabled=YES;
            NSString *imgName=[NSString stringWithFormat:@"new_feature_%d",i+1];
            UIImage *img=[UIImage imageNamed:imgName];
            imageView.image=img;
            imageView.frame=CGRectMake(i*size.width, 0, size.width, size.height);
            if (i==kCount-1) {
                UIButton *enter=[[UIButton alloc] init];
                [enter setTitle:@"进入微博" forState: UIControlStateNormal];
                [enter setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
                [enter setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
                [enter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [enter addTarget:self action:@selector(enterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                enter.size=enter.currentBackgroundImage.size;
                enter.centerX=imageView.wid*0.5;
                enter.centerY=imageView.hei-140;
                [imageView addSubview:enter];
                UIButton *choose=[[UIButton alloc] init];
                [choose setTitle:@"关注新浪官方微博" forState: UIControlStateNormal];
                [choose setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
                [choose setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
                [choose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [choose addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [choose sizeToFit];
                choose.centerX=imageView.wid*0.5;
                choose.centerY=imageView.hei-210;
                [imageView addSubview:choose];
                guideView.contentSize=CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
            }
            [guideView addSubview:imageView];
        }
        [self.view addSubview:guideView];
        [self.view addSubview:pageCtrl];
        self.pageCtrl=pageCtrl;
    }
    return self;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page=scrollView.contentOffset.x/self.view.wid +0.5;
    self.pageCtrl.currentPage=(int)page;
}
- (void) enterButtonClicked:(UIButton *)button {
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:kVersion];
    [WTXMWindowTool chooseRootViewController];
}
- (void) chooseButtonClicked:(UIButton *)button {
    button.selected=!button.selected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
