//
//  WTXMComposeViewController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMComposeViewController.h"
#import "WTXMStatusTextView.h"
#import "WTXMStatusImagesView.h"

@interface WTXMComposeViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak) WTXMStatusTextView *textView;
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
    __weak WTXMComposeViewController *myself=self;
    textView.toolButtonClick = ^(UIButton *button){
        [myself toolButtonClicked:button];
    };
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
#pragma mark -工具栏按钮点击监听

- (void) toolButtonClicked:(UIButton *)button {
    switch (button.tag) {
        case ToolButtonRelatedCamera:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
            }
            break;
        case ToolButtonRelatedPhotos:
            
            [self chooseAPhoto:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            
            break;
        case ToolButtonRelatedUsers:
            
            break;
        case ToolButtonRelatedTrend:
            
            break;
        case ToolButtonRelatedEmotion:
            [self switchKeyboard:button];
            break;
            
        default:
            break;
    }
}
- (void) chooseAPhoto:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType=type;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    [self.textView.imagesView addImage:img];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
    

- (void) switchKeyboard:(UIButton *)button {
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        //切回输入键盘
        [self.textView hideEmotionView];
    } else {
        [button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        //切回表情键盘
        [self.textView showEmotionView];
    }
    button.selected=!button.selected;
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
