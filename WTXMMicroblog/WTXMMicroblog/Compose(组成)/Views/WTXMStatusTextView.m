//
//  WTXMStatusTextView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMStatusTextView.h"
#import "WTXMStatusPhoto.h"
#import "WTXMStatusImagesView.h"
#import "WTXMEmotionView.h"
@interface WTXMStatusTextView ()
@property (nonatomic,weak) UITextField *placeHolder;
@property (nonatomic,strong) NSMutableArray *toolButtons;
@property (nonatomic,strong) UIView *toolBarView;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic,strong) WTXMEmotionView *emotionView;
@property (nonatomic,assign,getter=isKeyboard) BOOL keyboard;
@end

@implementation WTXMStatusTextView
- (WTXMEmotionView *)emotionView {
    if (!_emotionView) {
        CGFloat emotionHeight = 216;
        _emotionView= [[WTXMEmotionView alloc] initWithFrame:CGRectMake(0, self.hei-emotionHeight-64, self.wid, emotionHeight)];
        [self addSubview:_emotionView];
    }
    return _emotionView;
}

- (UIView *)imagesView {
    if (!_imagesView) {
        _imagesView = [WTXMStatusImagesView new];
        
        _imagesView.y = 100;
        _imagesView.wid = self.wid;
        [self addSubview:_imagesView];
    }
    return _imagesView;
}
- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}


- (UIView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [UIView new];
        _toolBarView.userInteractionEnabled=YES;
        _toolBarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        _toolBarView.wid = self.bounds.size.width;
        _toolBarView.hei = 44;
        _toolBarView.frame = CGRectMake(0, self.hei-_toolBarView.hei-64, _toolBarView.wid, _toolBarView.hei);
    }
    return _toolBarView;
}

- (NSMutableArray *)toolButtons {
    if (!_toolButtons) {
        _toolButtons = [NSMutableArray array];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"camerabutton_background"]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"toolbar_picture"]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"mentionbutton_background"]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"trendbutton_background"]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"emoticonbutton_background"]];
    }
    return _toolButtons;
}



- (UIButton *) addButtonInToolButtonsWithImageName:(NSString *)norName {
    UIButton *button = [UIButton new];
    NSString *nor = [NSString stringWithFormat:@"compose_%@",norName];
    NSString *high = [NSString stringWithFormat:@"compose_%@_highlighted",norName];
    [button setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:high] forState:UIControlStateHighlighted];
    
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font=[UIFont systemFontOfSize:16];
        [self addPlaceHolder];
        [self addTextToolBar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePlaceHolder:) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
        self.keyboard = YES;
    }
    return self;
}

- (void) addPlaceHolder {
    UITextField *placeHolder=[[UITextField alloc] init];
    self.placeHolder=placeHolder;
    placeHolder.placeholder=@"斑马斑马 你睡吧睡吧 我要卖掉我的房子 浪迹天涯";
    placeHolder.font=[UIFont systemFontOfSize:16];
    [placeHolder sizeToFit];
    placeHolder.enabled=NO;
    placeHolder.x = 5;
    placeHolder.y = 8;
    [self addSubview:placeHolder];
}

- (void) addTextToolBar {
    NSInteger count=self.toolButtons.count;
    CGFloat btnW = self.bounds.size.width/count;
    CGFloat btnH = self.toolBarView.hei;
    for (int i=0; i<count; i++) {
        UIButton *button = self.toolButtons[i];
        button.tag=i;
        button.frame = CGRectMake(btnW*i, 0, btnW, btnH);
       [ button addTarget:self action:@selector(toolButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBarView addSubview:button];
    }
    [self addSubview:self.toolBarView];
}

- (void)showEmotionView {
    
    if (self.editable) {
        self.keyboard = NO;
        [self endEditing:YES];
        self.emotionView.hidden = NO;
        self.toolBarView.y = self.emotionView.y-self.toolBarView.hei;
        
    }else {
        self.keyboard = NO;
        self.emotionView.hidden = NO;
        self.toolBarView.y = self.emotionView.y-self.toolBarView.hei;
    }
        }

- (void)hideEmotionView {
    self.emotionView.hidden = YES;
     self.keyboard = YES;
}


- (void) toolButtonClicked:(UIButton *)button {
    self.toolButtonClick(button);
}


- (void) hidePlaceHolder:(NSNotification *)notify {
   
        self.placeHolder.hidden=self.text.length;
    
}
- (void) keyboardFrameChanged:(NSNotification *)notify {
    if (self.isKeyboard) {
        NSValue *rectValue = notify.userInfo[UIKeyboardFrameEndUserInfoKey];
        CGRect rect = [rectValue CGRectValue];
        [UIView animateWithDuration:0.25 animations:^{
            self.toolBarView.y = rect.origin.y-self.toolBarView.hei-64;
        }];
    }
   }
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
