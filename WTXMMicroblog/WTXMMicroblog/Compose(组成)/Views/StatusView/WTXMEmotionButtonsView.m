//
//  WTXMEmotionButtonsView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/30.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMEmotionButtonsView.h"
#import "WTXMEmotionModel.h"
#import "WTXMEmojiEmotionModel.h"
@interface WTXMEmotionButtonsView ()
@property (nonatomic,weak) UIButton *emotionButton;
@property (nonatomic,strong) NSArray *defaultEmotions;
@property (nonatomic,strong) NSArray *emojiEmotions;
@property (nonatomic,strong) NSArray *lxhEmotions;
@end

@implementation WTXMEmotionButtonsView
- (NSArray *)defaultEmotions {
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default/info.plist" ofType:nil];
        _defaultEmotions = [NSArray arrayWithContentsOfFile:path];
        _defaultEmotions = [WTXMEmotionModel objectArrayWithKeyValuesArray:_defaultEmotions];
    }
    return _defaultEmotions;
}
- (NSArray *)emojiEmotions {
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji/info.plist" ofType:nil];
        _emojiEmotions = [NSArray arrayWithContentsOfFile:path];
        _emojiEmotions = [WTXMEmojiEmotionModel objectArrayWithKeyValuesArray:_emojiEmotions];
    }
    return _emojiEmotions;
}
- (NSArray *)lxhEmotions {
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lxh/info.plist" ofType:nil];
        _lxhEmotions = [NSArray arrayWithContentsOfFile:path];
        _lxhEmotions = [WTXMEmotionModel objectArrayWithKeyValuesArray:_lxhEmotions];
    }
    return _lxhEmotions;
}


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
    switch (button.tag) {
        case WTXMEmotionTypeRecent:
            [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionButtonDidClickedNotification object:nil];
            break;
        case WTXMEmotionTypeDefault:
            [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionButtonDidClickedNotification object:self.defaultEmotions];
            break;
        case WTXMEmotionTypeEmoji:
            [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionButtonDidClickedNotification object:self.emojiEmotions];
            break;
        case WTXMEmotionTypeLxh:
            [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionButtonDidClickedNotification object:self.lxhEmotions];
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews {
       [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.wid/count;
    for (int i=0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.tag = i;
        button.frame = CGRectMake(i*btnW, 0, btnW, button.hei);
        if (i==1) {
            button.selected = YES;
            self.emotionButton = button;
            [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionButtonDidClickedNotification object:self.defaultEmotions];
        }
    }
}


@end
