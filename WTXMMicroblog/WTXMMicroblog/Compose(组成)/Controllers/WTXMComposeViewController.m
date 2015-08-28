//
//  WTXMComposeViewController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMComposeViewController.h"
#import "WTXMStatusTextView.h"

@interface WTXMComposeViewController ()<UITextViewDelegate>
@property (nonatomic,weak) UITextView *textView;
@property (nonatomic,weak) UITextField *placeHolder;
@end

@implementation WTXMComposeViewController

- (instancetype)init {
    if (self=[super init]) {
        [self setNavigationItem];
        [self addTextView];
    }
    return self;
}

- (void) addTextView {
   
    WTXMStatusTextView *textView=[[WTXMStatusTextView alloc] initWithFrame:self.view.bounds];
    textView.delegate=self;
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void) setNavigationItem {
    UILabel *title=[[UILabel alloc] init];
    title.numberOfLines=2;
    title.textAlignment=NSTextAlignmentCenter;
    NSString *titleText=@"发消息";
    NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"_user.name"];
    if (name) {
        NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",titleText,name]];
        NSRange titleTextRange=[[attrString string] rangeOfString:titleText];
        NSRange userNameRange=[[attrString string] rangeOfString:name];

        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:titleTextRange];
       
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:userNameRange];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:userNameRange];
        title.attributedText=attrString;
        [title sizeToFit];
        self.navigationItem.titleView=title;
    }else {
        self.navigationItem.title=titleText;
    }
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTitle:@"取消" target:self action:@selector(cancel)];
     self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTitle:@"发送" target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
   
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) sendStatus {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (self.textView.text.length) {
        self.navigationItem.rightBarButtonItem.enabled=YES;
        
    }else {
        self.navigationItem.rightBarButtonItem.enabled=NO;
        
    }
}

@end
