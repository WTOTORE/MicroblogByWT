//
//  WTXMBasicNavigationController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/13.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMBasicNavigationController.h"

@interface WTXMBasicNavigationController ()

@end

@implementation WTXMBasicNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count>=1) {
        NSString *back=@"返回";
        if (self.viewControllers.count==1) {
            viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" Title:[self.viewControllers.firstObject title] target:self action:@selector(back)];
        }
         viewController.hidesBottomBarWhenPushed=YES;
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" Title:back target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}
- (void) back {
    [self popViewControllerAnimated:YES];
}
@end
