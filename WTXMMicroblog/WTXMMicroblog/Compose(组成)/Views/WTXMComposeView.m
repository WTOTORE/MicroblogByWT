//
//  WTXMComposeView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/25.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMComposeView.h"
#import "WTXMComposeButton.h"
#import "WTXMComposeButtonModel.h"
#import "WTXMComposeViewController.h"
#import "WTXMBasicNavigationController.h"
#define kWINDOW [UIApplication sharedApplication].keyWindow
@interface WTXMComposeView ()
@property (nonatomic,strong) NSArray *buttonModelsArray;
@property (nonatomic,strong) NSMutableArray *buttons;
@end

@implementation WTXMComposeView
- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSArray *)buttonModelsArray {
    if (!_buttonModelsArray) {
       _buttonModelsArray = [WTXMComposeButtonModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"compose" ofType:@"plist"]]];
    }
    return _buttonModelsArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
        [imageView sizeToFit];
        imageView.centerX=kWINDOW.centerX;
        imageView.centerY=150;
        [self addSubview:imageView];
        [self addButtons];
        [self didBeginButtonAnimation];
    }
    return self;
}

- (void) setBackgroundImage {
    
    UIGraphicsBeginImageContext(kWINDOW.bounds.size);
    CGContextRef ctf = UIGraphicsGetCurrentContext();
    [kWINDOW.layer renderInContext:ctf];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor=[UIColor colorWithPatternImage:[img applyLightEffect]];

}

- (void) addButtons {
    
    CGFloat btnWH=kWINDOW.wid/3.0;
    NSInteger maxCol=3;
   NSInteger count=self.buttonModelsArray.count;
    for (int i=0; i<count; i++) {
        WTXMComposeButtonModel *buttonModel=self.buttonModelsArray[i];
        WTXMComposeButton *button = [[WTXMComposeButton alloc] init];
        int row=i/maxCol;
        int col=i%maxCol;
        button.tag=i;
        [button addTarget:self action:@selector(composeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonModel.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonModel.icon] forState:UIControlStateNormal];
        button.frame = CGRectMake(btnWH*col, kWINDOW.hei+row*btnWH, btnWH, btnWH);
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}

- (void) composeButtonClicked:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        [self.buttons enumerateObjectsUsingBlock:^(WTXMComposeButton *obj, NSUInteger idx, BOOL *stop) {
            if (idx==button.tag) {
                obj.transform=CGAffineTransformMakeScale(2.0, 2.0);
                obj.alpha=0.1;
            }else {
                obj.transform=CGAffineTransformMakeScale(0.5, 0.5);
                obj.alpha=0.1;
            }
        }];
    } completion:^(BOOL finished) {
        if (finished) {
             WTXMBasicNavigationController *nav=[[WTXMBasicNavigationController alloc] initWithRootViewController:[[WTXMComposeViewController alloc] init]];
            [self.target presentViewController:nav animated:YES completion:^{
                [self removeFromSuperview];
            }];
        }
    }];
    
   
    
}



- (void) didBeginButtonAnimation {
    
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        [obj performAnimationWithBeginTime:idx*0.025 Type:WTXMComposeButtonTypeUp];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   NSArray *temp = [self.buttons reverseObjectEnumerator].allObjects;
    [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj performAnimationWithBeginTime:idx*0.025 Type:WTXMComposeButtonTypeDown];
    }] ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha=0;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    });
    
}
@end
