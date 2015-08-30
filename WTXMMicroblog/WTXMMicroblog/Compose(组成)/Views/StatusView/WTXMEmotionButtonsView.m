//
//  WTXMEmotionButtonsView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/30.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMEmotionButtonsView.h"
@interface WTXMEmotionButtonsView ()
@property (nonatomic,weak) UIButton *emotionButton;

@end

@implementation WTXMEmotionButtonsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addButtonWithTitle:@"最近" BackgroundImageName:@"left"];
        [self addButtonWithTitle:@"默认" BackgroundImageName:@"mid"];
        [self addButtonWithTitle:@"Emoji" BackgroundImageName:@"mid"];
        [self addButtonWithTitle:@"浪小花" BackgroundImageName:@"right"];
    }
    return self;
}

- (void) addButtonWithTitle:(NSString *)title BackgroundImageName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    NSString *nor = [NSString stringWithFormat:@"compose_emotion_table_%@_normal",imageName];
    NSString *sel = [NSString stringWithFormat:@"compose_emotion_table_%@_selected",imageName];
    [button setBackgroundImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:sel] forState:UIControlStateSelected];
    button.hei = button.currentBackgroundImage.size.height;
    button.highlightEnabled = NO;
    [button addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}
- (void) emotionButtonClicked:(UIButton *)button {
    self.emotionButton.selected = NO;
    button.selected = YES;
    self.emotionButton = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.wid/count;
    for (int i=0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(i*btnW, 0, btnW, button.hei);
    }
}


@end
