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

@implementation WTXMEmotionsPageView

- (instancetype)initWithFrame:(CGRect)frame Emotions:(NSArray *)emotionArr {
    if (self = [super initWithFrame:frame]) {
        [self addButtonsWithEmotions:emotionArr];
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
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:emoji.code];
                [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:35] range:NSMakeRange(0, emoji.code.length)];
                [button setAttributedTitle:attr forState:UIControlStateNormal];
//                [button setTitle:emoji.code forState:UIControlStateNormal];
//                button.titleLabel.font = [UIFont systemFontOfSize:35];
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
                [button setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateNormal];
                button.frame = CGRectMake(col*btnW, row*btnH, btnW, btnH);
                [button addTarget:self action:@selector(deleteEmotion) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }else {
                WTXMEmotionModel *emotion = emotionArr[i];
                UIButton *button = [[UIButton alloc] init];
//                NSString *path = [NSString stringWithFormat:@""]
               [button setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
                button.frame = CGRectMake(col*btnW, row*btnH, btnW, btnH);
                [button addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
            }
        }

        
        
        
    }
}

- (void) emotionButtonClicked:(UIButton *)button {
    
}

- (void) deleteEmotion {
    
}
@end
