//
//  WTXMMainTabBarController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/13.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMMainTabBarController.h"
#import "WTXMTabBar.h"
#import "WTXMHomeTableViewController.h"
#import "WTXMMessageTableViewController.h"
#import "WTXMDiscoverTableViewController.h"
#import "WTXMProfileTableViewController.h"
#import "WTXMBasicNavigationController.h"


@interface WTXMMainTabBarController ()<WTXMTabBarDelegate>

@end

@implementation WTXMMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationControllers];
    [self setTabBar];
    }
- (void) setTabBar {
    WTXMTabBar *tabBar=[[WTXMTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.delegate=self;
    [self setValue:tabBar forKey:@"tabBar"];
    self.tabBar.tintColor=[UIColor orangeColor];

}
- (void) setNavigationControllers {
    WTXMHomeTableViewController *navHome=[[WTXMHomeTableViewController alloc] init];
    [self addViewControllerWithController:navHome Title:@"首页" ImageName:@"home"];
    WTXMMessageTableViewController *navMessage=[[WTXMMessageTableViewController alloc] init];
    [self addViewControllerWithController:navMessage Title:@"信息" ImageName:@"message_center"];
    WTXMDiscoverTableViewController *navDiscover=[[WTXMDiscoverTableViewController alloc] init];
    [self addViewControllerWithController:navDiscover Title:@"发现" ImageName:@"discover"];
    WTXMProfileTableViewController *navProfile=[[WTXMProfileTableViewController alloc] init];
    [self addViewControllerWithController:navProfile Title:@"我" ImageName:@"profile"];
}
- (void) addViewControllerWithController:(UIViewController *)viewController Title:(NSString *)title ImageName:(NSString *)imageName {
    viewController.title=title;
    NSString *nor=[NSString stringWithFormat:@"tabbar_%@",imageName];
    NSString *sel=[NSString stringWithFormat:@"tabbar_%@_selected",imageName];
    [viewController.tabBarItem setImage:[WTXMSkinImage skinImageNamed:nor]];
    [viewController.tabBarItem setSelectedImage:[WTXMSkinImage skinImageNamed:sel]];
    [self addChildViewController:[[WTXMBasicNavigationController alloc] initWithRootViewController:viewController]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBar:(WTXMTabBar *)tabBar didSelectPlusButton:(UIButton *)button {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
