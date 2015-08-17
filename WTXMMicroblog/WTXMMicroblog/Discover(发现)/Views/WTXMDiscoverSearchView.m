//
//  WTXMDiscoverSearchView.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/1/1.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMDiscoverSearchView.h"
@interface WTXMDiscoverSearchView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTextRightConstraints;


@end

@implementation WTXMDiscoverSearchView
+(instancetype)discoverSearch {
    return [[NSBundle mainBundle] loadNibNamed:@"WTXMDiscoverSearchView" owner:nil options:nil].lastObject;
}
/**
 *  子控件连线之后调用
 */
- (void)awakeFromNib {
    UIImageView *imgView=[[UIImageView alloc] init];
    imgView.image=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
    imgView.contentMode=UIViewContentModeCenter;
    imgView.size=CGSizeMake(self.hei, self.hei);
    self.searchText.leftView=imgView;
    self.searchText.leftViewMode=UITextFieldViewModeAlways;
    self.searchText.delegate=self;
    [self.cancleButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searchTextRightConstraints.constant=self.cancleButton.wid;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void) cancel:(UIButton *)button {
    [self.searchText resignFirstResponder];
    self.searchTextRightConstraints.constant=0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
/**
 *  子控件连线之前调用(即上面 "weak" 控件的属性值都为空)
 *
 *  @param aDecoder
 *
 *  @return
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}
@end
