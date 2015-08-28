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
@interface WTXMStatusTextView ()
@property (nonatomic,weak) UITextField *placeHolder;
@property (nonatomic,strong) NSMutableArray *toolButtons;
@property (nonatomic,strong) UIView *toolBarView;
@property (nonatomic,strong) NSMutableArray *imagesArray;

@end

@implementation WTXMStatusTextView
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
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"camerabutton_background" SelectedName:nil]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"toolbar_picture" SelectedName:nil]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"mentionbutton_background" SelectedName:nil]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"trendbutton_background" SelectedName:nil]];
        [_toolButtons addObject:[self addButtonInToolButtonsWithImageName:@"emoticonbutton_background" SelectedName:@"keyboardbutton_background"]];
    }
    return _toolButtons;
}



- (UIButton *) addButtonInToolButtonsWithImageName:(NSString *)norName SelectedName:(NSString *)selName {
    UIButton *button = [UIButton new];
    NSString *nor = [NSString stringWithFormat:@"compose_%@",norName];
    NSString *high = [NSString stringWithFormat:@"compose_%@_highlighted",norName];
    NSString *sel = [NSString stringWithFormat:@"compose_%@_",selName];
    [button setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:high] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:sel] forState:UIControlStateSelected];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font=[UIFont systemFontOfSize:16];
        [self addPlaceHolder];
        [self addTextToolBar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePlaceHolder:) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    placeHolder.y=8;
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

- (void) toolButtonClicked:(UIButton *)button {
    self.toolButtonClick(button.tag);
}

- (void) switchKeyboard:(UIButton *)button {
    if (button.selected) {
        //切回输入键盘
    } else {
        //切回表情键盘
    }
}

- (void) hidePlaceHolder:(NSNotification *)notify {
   
        self.placeHolder.hidden=self.text.length;
    
}
- (void) keyboardFrameChanged:(NSNotification *)notify {
    NSValue *rectValue = notify.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [rectValue CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.toolBarView.y = rect.origin.y-self.toolBarView.hei-64;
    }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
