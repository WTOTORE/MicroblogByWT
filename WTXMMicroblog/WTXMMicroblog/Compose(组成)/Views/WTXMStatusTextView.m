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
#import "WTXMEmojiEmotionModel.h"
#import "WTXMEmotionModel.h"
#define k_TEXT_FONT 16
@interface WTXMStatusTextView ()
@property (nonatomic, weak) UITextField* placeHolder;
@property (nonatomic, strong) NSMutableArray* toolButtons;
@property (nonatomic, strong) UIView* toolBarView;
@property (nonatomic, strong) NSMutableArray* imagesArray;
@property (nonatomic, strong) WTXMEmotionView* emotionView;
@property (nonatomic, assign, getter=isKeyboard) BOOL keyboard;
@end

@implementation WTXMStatusTextView

- (WTXMEmotionView*)emotionView
{
    if (!_emotionView) {
        CGFloat emotionHeight = 216;
        _emotionView = [[WTXMEmotionView alloc] initWithFrame:CGRectMake(0, 0, self.wid, emotionHeight)];
    }
    return _emotionView;
}

- (UIView*)imagesView
{
    if (!_imagesView) {
        _imagesView = [WTXMStatusImagesView new];

        _imagesView.y = 100;
        _imagesView.wid = self.wid;
        [self addSubview:_imagesView];
    }
    return _imagesView;
}
- (NSMutableArray*)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (UIView*)toolBarView
{
    if (!_toolBarView) {
        _toolBarView = [UIView new];
        _toolBarView.userInteractionEnabled = YES;
        _toolBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        _toolBarView.wid = self.bounds.size.width;
        _toolBarView.hei = 44;
        _toolBarView.frame = CGRectMake(0, self.hei - _toolBarView.hei - 64, _toolBarView.wid, _toolBarView.hei);
    }
    return _toolBarView;
}

- (NSMutableArray*)toolButtons
{
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

- (UIButton*)addButtonInToolButtonsWithImageName:(NSString*)norName
{
    UIButton* button = [UIButton new];
    NSString* nor = [NSString stringWithFormat:@"compose_%@", norName];
    NSString* high = [NSString stringWithFormat:@"compose_%@_highlighted", norName];
    [button setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:high] forState:UIControlStateHighlighted];

    return button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:k_TEXT_FONT];
        [self addPlaceHolder];
        [self addTextToolBar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePlaceHolder:) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addEmotion:) name:WTXMEmotionDidClickedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBackward) name:WTXMEmotionDleteButtonDidClickedNotification object:nil];
        self.keyboard = YES;
    }
    return self;
}

- (void)addPlaceHolder
{
    UITextField* placeHolder = [[UITextField alloc] init];
    self.placeHolder = placeHolder;
    placeHolder.placeholder = @"斑马斑马 你睡吧睡吧 我要卖掉我的房子 浪迹天涯";
    placeHolder.font = [UIFont systemFontOfSize:k_TEXT_FONT];
    [placeHolder sizeToFit];
    placeHolder.enabled = NO;
    placeHolder.x = 5;
    placeHolder.y = 8;
    [self addSubview:placeHolder];
}

- (void)addTextToolBar
{
    NSInteger count = self.toolButtons.count;
    CGFloat btnW = self.bounds.size.width / count;
    CGFloat btnH = self.toolBarView.hei;
    for (int i = 0; i < count; i++) {
        UIButton* button = self.toolButtons[i];
        button.tag = i;
        button.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        [button addTarget:self action:@selector(toolButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBarView addSubview:button];
    }
    [self addSubview:self.toolBarView];
}

- (void)showEmotionView
{
    self.keyboard = NO;
    [self endEditing:YES];
     self.inputView = self.emotionView;
    [self becomeFirstResponder];
}

- (void)hideEmotionView
{
    
    [self endEditing:YES];
     self.keyboard = YES;
    self.inputView = nil;
    [self becomeFirstResponder];
    
}

- (void)toolButtonClicked:(UIButton*)button
{
    self.toolButtonClick(button);
}

- (void)hidePlaceHolder:(NSNotification*)notify
{

    self.placeHolder.hidden = self.text.length;
}
- (void)keyboardFrameChanged:(NSNotification*)notify
{
    NSValue* rectValue = notify.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [rectValue CGRectValue];
    if (self.isKeyboard) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             self.toolBarView.y = rect.origin.y - self.toolBarView.hei - 64;
                         }];
    }else if (rect.origin.y!=self.bounds.size.height) {
             self.toolBarView.y = rect.origin.y - self.toolBarView.hei - 64;
        }
}
- (void)addEmotion:(NSNotification*)notify
{
    
    NSMutableAttributedString* attrs = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange selectedRange = [self selectedRange];
    [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:k_TEXT_FONT] range:NSMakeRange(0, self.text.length)];
     NSRange emotionRange;
    if ([notify.object isKindOfClass:[WTXMEmojiEmotionModel class]]) {
        WTXMEmojiEmotionModel *emoji = notify.object;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[emoji.code emoji]];
        emotionRange = NSMakeRange(0, [emoji.code emoji].length);
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:k_TEXT_FONT] range:emotionRange];
        [attrs replaceCharactersInRange:selectedRange withAttributedString:attr];
    }else {
        WTXMEmotionModel *emotion = notify.object;
        NSTextAttachment *atta = [[NSTextAttachment alloc] init];
        atta.image = [UIImage imageNamed:emotion.png];
        CGFloat imgWH = self.font.lineHeight;
        atta.bounds = CGRectMake(0, -imgWH*0.2, imgWH, imgWH);
        NSAttributedString *attaS = [NSAttributedString attributedStringWithAttachment:atta];
         emotionRange = NSMakeRange(0, attaS.length);
        
        
        [attrs replaceCharactersInRange:selectedRange withAttributedString:attaS];
        [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:k_TEXT_FONT] range:NSMakeRange(0, attrs.length)];
    }
    self.attributedText = attrs;
    if (attrs) {
        if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [self.delegate textViewDidChange:self];
        }
        self.placeHolder.hidden = YES;
    }
    self.selectedRange = NSMakeRange(selectedRange.location+emotionRange.length, 0);
}

- (void)deleteBackward {
    [super deleteBackward];
    if (!self.attributedText) {
        self.placeHolder.hidden = NO;
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
