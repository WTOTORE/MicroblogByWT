//
//  WTXMEmotionsPageView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/30.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMEmotionsPageView.h"
#import "WTXMEmojiEmotionModel.h"
#import "WTXMEmotionModel.h"
@interface WTXMEmotionsPageView ()
@property (nonatomic,strong) NSArray *emotions;
@property (nonatomic,weak) UIImageView *emotion;
@end

@implementation WTXMEmotionsPageView
- (UIImageView *)emotion {
    if (!_emotion) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
        [imgView sizeToFit];
        imgView.layer.anchorPoint = CGPointMake(0.5, 1);
        [self addSubview:imgView];
        _emotion = imgView;
    }
    return _emotion;
}
- (instancetype)initWithFrame:(CGRect)frame Emotions:(NSArray *)emotionArr {
    if (self = [super initWithFrame:frame]) {
        [self addButtonsWithEmotions:emotionArr];
        self.emotions= emotionArr;
    }
    return self;
}

- (void) addButtonsWithEmotions:(NSArray *)emotionArr {
    NSInteger maxCol = 7;
    NSInteger maxRow = 3;
    CGFloat btnW = self.wid/maxCol;
    CGFloat btnH = self.hei/maxRow;
    NSInteger count = emotionArr.count;
    
    if ([[emotionArr firstObject] isKindOfClass:[WTXMEmojiEmotionModel class]] ) {
        for (int i=0; i<count+1; i++) {
            int col = i%maxCol;
            int row = i/maxCol;
            if (i==count) {
                UIButton *button = [[UIButton alloc] init];
                [button setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateNormal];
                button.frame = CGRectMake(col*btnW, row*btnH, btnW, btnH);
                [button addTarget:self action:@selector(deleteEmotion) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }else {
                WTXMEmojiEmotionModel *emoji = emotionArr[i];
                UIButton *button = [[UIButton alloc] init];
                button.tag = i;
                [button setTitle:[emoji.code emoji] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:35];
                button.frame = CGRectMake(col*btnW, row*btnH, btnW, btnH);
                [button addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];

            }
            
        }
        
        
        
    }else {
        for (int i=0; i<count+1; i++) {
            int col = i%maxCol;
            int row = i/maxCol;
            if (i==count) {
                UIButton *button = [[UIButton alloc] init];
                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showEmotion:)];
                
                [button addGestureRecognizer:longPress];
                button.tag = i;
                [button setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateNormal];
                button.frame = CGRectMake(col*btnW, row*btnH, btnW, btnH);
                [button addTarget:self action:@selector(deleteEmotion) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }else {
                WTXMEmotionModel *emotion = emotionArr[i];
                UIButton *button = [[UIButton alloc] init];
                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showEmotion:)];
                
                [button addGestureRecognizer:longPress];
                button.tag = i;
               [button setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
                button.frame = CGRectMake(col*btnW, row*btnH, btnW, btnH);
                [button addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
            }
        }

        
        
        
    }
}

- (void) emotionButtonClicked:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionDidClickedNotification object:self.emotions[button.tag]];
}
- (void) showEmotion:(UIGestureRecognizer *)recognizer {
    UIButton *button = (UIButton *)recognizer.view;
//    WTXMEmotionModel *emotion = self.emotions[button.tag];
    self.emotion.center = button.center;
    
    self.emotion.hidden = NO;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.emotion.hidden = YES;
}
//#pragma mark - UIGestureRecognizerDelegate


- (void) deleteEmotion {
    [[NSNotificationCenter defaultCenter] postNotificationName:WTXMEmotionDleteButtonDidClickedNotification object:nil];
}
@end
