//
//  WTXMHomeTableViewController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/14.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHomeTableViewController.h"
#import "WTXMHomeButton.h"
#import "WTXMUserModel.h"
#import "WTXMBlogModel.h"
#import "WTXMHomeFooterView.h"
#import "WTXMUnreadCountModel.h"
#import "WTXMHomeTableViewCell.h"
#import "WTXMStatusFrameModel.h"
#import "WTXMStatusesModel.h"
#import "WTXMHomeHTTPRequestTool.h"

@interface WTXMHomeTableViewController ()
@property (nonatomic,strong) WTXMHomeButton *homeBtn;
@property (nonatomic,strong) WTXMUserModel *user;
@property (nonatomic,strong) NSMutableArray *statusFrames;
@property (nonatomic,weak) UIRefreshControl *refresh;
@end

@implementation WTXMHomeTableViewController
-(NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames=[NSMutableArray array];
    }
    return _statusFrames;
}
- (instancetype)init {
    if (self=[super init]) {
        self.homeBtn=[[WTXMHomeButton alloc] init];
        NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"_user.name"];
        if (name) {
            [self.homeBtn setTitle:name forState:UIControlStateNormal];
        }else {
            [self.homeBtn setTitle:self.user.screen_name forState:UIControlStateNormal];
        }
       
        self.navigationItem.titleView=self.homeBtn;
        self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(friendsearch)];
        self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(pop)];
    }
        return self;
}
- (WTXMUserModel *)user {
    if (!_user) {
        [WTXMHomeHTTPRequestTool getUserInfoSuccess:^(WTXMUserModel *user) {
            _user=user;
        } Failure:^(NSError *error) {
            
        }];
         }
    return _user;
}

- (void) friendsearch {
    
}
- (void) pop {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[WTXMHomeTableViewCell class] forCellReuseIdentifier:WTXMHomeTableViewCell_ID];
    [self setSeparatorInsetWithTableView:self.tableView inset:UIEdgeInsetsZero];
    [self setupRefresh];
    NSTimer *timer=[NSTimer timerWithTimeInterval:300 target:self selector:@selector(getUnLoadBlogsCount) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
  
   }
/**
 *  设置系统刷新控件
 */
- (void)setupRefresh {
    UIRefreshControl *refresh=[[UIRefreshControl alloc] init];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(loadNewBlogs:) forControlEvents:UIControlEventValueChanged];
    [refresh beginRefreshing];
    self.refresh=refresh;
    [self loadNewBlogs:refresh];
    WTXMHomeFooterView *footerView=[WTXMHomeFooterView footerView];
    self.tableView.tableFooterView=footerView;

    footerView.hidden=YES;
}
/**
 *  更新微博数据
 *
 *
 */
- (void) loadNewBlogs:(UIRefreshControl *)refresh {
    [WTXMHomeHTTPRequestTool loadNewStatusesWithModelArray:self.statusFrames RefreshControl:refresh Success:^(id array) {
        NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [array count])];
        [self.statusFrames insertObjects:array atIndexes:indexSet];
        [self showRefreshCountLable:[array count]];
        [self.tableView reloadData];
        [self getUnLoadBlogsCount];
    } Failure:^(NSError *error) {
        
    }];
}
/**
 *  获取以前的微博
 */
- (void)loadOldBlogs {
    [WTXMHomeHTTPRequestTool loadOldStatusesWithModelArray:self.statusFrames RefreshControl:_refresh Success:^(id array) {
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden=YES;
    } Failure:^(NSError *error) {
        
    }];
}
- (void)getUnLoadBlogsCount {
    [WTXMHomeHTTPRequestTool getUnreadStatusCountSuccess:^(WTXMUnreadCountModel *unreadCount) {
        if (unreadCount.status) {
            self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",unreadCount.status];
            [UIApplication sharedApplication].applicationIconBadgeNumber=unreadCount.status;
        }else {
            self.tabBarItem.badgeValue=nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
        }
    } Failure:^(NSError *error) {
        
    }];
}
/**
 *  加载了多少条微博的提示
 *
 *  @param count
 */
- (void) showRefreshCountLable:(NSInteger)count {
    UILabel *refreshCount=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame)-35, [UIScreen mainScreen].bounds.size.width, 35)];
    refreshCount.backgroundColor=[UIColor orangeColor];
    refreshCount.textAlignment=NSTextAlignmentCenter;
    if (!count) {
         refreshCount.text=@"微博无更新~";
    }else {
    refreshCount.text=[NSString stringWithFormat:@"有%ld条微博更新", (long)count];
    }
    [self.navigationController.view insertSubview:refreshCount belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1 animations:^{
        refreshCount.transform=CGAffineTransformMakeTranslation(0, refreshCount.hei);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 delay:1 options:0 animations:^{
                 refreshCount.transform=CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    [refreshCount removeFromSuperview];
                }
            }];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getUnLoadBlogsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WTXMHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WTXMHomeTableViewCell_ID];
    
    WTXMStatusFrameModel *statusFrame=self.statusFrames[indexPath.row];
    cell.statusFrame=statusFrame;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     WTXMStatusFrameModel *statusFrame=self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.statusFrames.count==0) {
        return;
    }
    if (self.tableView.tableFooterView.hidden==NO) {
        return;
    }
    
    if(scrollView.contentOffset.y>(scrollView.contentSize.height-scrollView.hei+self.navigationController.navigationBar.hei-20+self.tabBarController.tabBar.hei-self.tableView.tableFooterView.hei)) {
        self.tableView.tableFooterView.hidden=NO;
        self.tableView.tableFooterView.hei=35;
        [self loadOldBlogs];
    }
}

@end
