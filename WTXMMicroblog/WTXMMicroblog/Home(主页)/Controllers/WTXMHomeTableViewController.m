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

@interface WTXMHomeTableViewController ()
@property (nonatomic,strong) WTXMHomeButton *homeBtn;
@property (nonatomic,strong) WTXMUserModel *user;
@property (nonatomic,strong) NSMutableArray *statusFrames;
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
        WTXMAccountModel *account=[WTXMAccountTool account];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSString *urlStr=@"https://api.weibo.com/2/users/show.json";
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        parameters[@"access_token"]=account.access_token;
        parameters[@"uid"]=account.uid;
        [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation * operation, NSDictionary *response) {
            
            _user=[[WTXMUserModel alloc] init];
            [_user setKeyValues:response];
            [[NSUserDefaults standardUserDefaults] setObject:_user.screen_name forKey:@"_user.name"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"error:%@",error);
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
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *urlStr=@"https://api.weibo.com/2/statuses/home_timeline.json";
    WTXMAccountModel *account=[WTXMAccountTool account];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    parameters[@"count"]=@20;//默认为20
    parameters[@"since_id"]=@([[[self.statusFrames firstObject] blog] id]);//此处是 since_id 和 statuses 字典里面的 id 作比较,而不是 since_id
[manager GET:urlStr parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id response) {
    [refresh endRefreshing];
    NSArray *dictArr=response[@"statuses"];
    NSArray *blogArr=[WTXMBlogModel objectArrayWithKeyValuesArray:dictArr];
    NSMutableArray *tempArr=[NSMutableArray array];
    for (WTXMBlogModel *blog in blogArr) {
        WTXMStatusFrameModel *statusFrame=[[WTXMStatusFrameModel alloc] init];
        statusFrame.blog=blog;
        [tempArr addObject:statusFrame];
    }
    blogArr=tempArr;
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, blogArr.count)];
    [self.statusFrames insertObjects:blogArr atIndexes:indexSet];
    [self showRefreshCountLable:blogArr.count];
    [self.tableView reloadData];
    [self getUnLoadBlogsCount];
} failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
    
}];
}
/**
 *  获取以前的微博
 */
- (void)loadOldBlogs {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *urlStr=@"https://api.weibo.com/2/statuses/home_timeline.json";
    WTXMAccountModel *account=[WTXMAccountTool account];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    parameters[@"count"]=@20;//默认为20
    parameters[@"max_id"]=@([[[self.statusFrames firstObject] blog] id]-1);//此处是 since_id 和 statuses 字典里面的 id 作比较,而不是 since_id
    [manager GET:urlStr parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id response) {
        NSArray *dictArr=response[@"statuses"];
        NSArray *blogArr=[WTXMBlogModel objectArrayWithKeyValuesArray:dictArr];
        NSMutableArray *tempArr=[NSMutableArray array];
        for (WTXMBlogModel *blog in blogArr) {
            WTXMStatusFrameModel *statusFrame=[[WTXMStatusFrameModel alloc] init];
            statusFrame.blog=blog;
            [tempArr addObject:statusFrame];
        }
        blogArr=tempArr;
        [self.statusFrames addObjectsFromArray:blogArr];
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden=YES;
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];

}
- (void)getUnLoadBlogsCount {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *urlStr=@"https://rm.api.weibo.com/2/remind/unread_count.json";
    WTXMAccountModel *account=[WTXMAccountTool account];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    /**
     *
     必选	类型及范围	说明
     source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。

     */
    parameters[@"access_token"]=account.access_token;
    parameters[@"uid"]=account.uid;
  
    [manager GET:urlStr parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id response) {
        WTXMUnreadCountModel *unreadCount=[[WTXMUnreadCountModel alloc] init];
        [unreadCount setKeyValues:response];
        if (unreadCount.status) {
            self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",unreadCount.status];
            [UIApplication sharedApplication].applicationIconBadgeNumber=unreadCount.status;
        }else {
            self.tabBarItem.badgeValue=nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
        }
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
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

#pragma mark - Table view data source


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
    return statusFrame.originateViewHeight;
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
