//
//  WTXMLoginSinaController.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/19.
//  Copyright (c) 2015年 王涛. All rights reserved.
//
/**
 *
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
 scope	false	string	申请scope权限所需参数，可一次申请多个scope权限，用逗号分隔。使用文档
 state	false	string	用于保持请求和回调的状态，在回调时，会在Query Parameter中回传该参数。开发者可以用这个参数验证请求有效性，也可以记录用户请求授权页前的位置。这个参数可用于防止跨站请求伪造（CSRF）攻击
 display	false	string	授权页面的终端类型，取值见下面的说明。
 forcelogin	false	boolean	是否强制用户重新登录，true：是，false：否。默认false。
 language	false	string	授权页语言，缺省为中文简体版，en为英文版。英文版测试中，开发者任何意见可反馈至 @微博API
 
 display说明：
 参数取值	类型说明
 default	默认的授权页面，适用于web浏览器。
 mobile	移动终端的授权页面，适用于支持html5的手机。注：使用此版授权页请用 https://open.weibo.cn/oauth2/authorize 授权接口
 wap	wap版授权页面，适用于非智能手机。
 client	客户端版本授权页面，适用于PC桌面应用。
 apponweibo	默认的站内应用授权页，授权后不返回access_token，只刷新站内应用父框架。
#return value description#>
 */
/**
 *  App Key：2717459208
 App Secret：d322aab81de02945ee7a3ffbbe838b33
 */
#import "WTXMLoginSinaController.h"
#import "AppDelegate.h"
#define APP_KEY @"2717459208"
#define APP_SECRET @"d322aab81de02945ee7a3ffbbe838b33"
#define REDIRECT_URI @"http://www.sina.com.cn"
#import <AFNetworking/AFNetworking.h>
@interface WTXMLoginSinaController ()<UIWebViewDelegate>

@end

@implementation WTXMLoginSinaController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView=[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.delegate=self;
    [self.view addSubview:webView];
    NSString *urlString=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",APP_KEY,REDIRECT_URI];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//拿到请求的 URL, 决定是否加载
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr=request.URL.absoluteString;
    if ([urlStr hasPrefix:REDIRECT_URI]) {
        NSRange range=[urlStr rangeOfString:@"code="];
        NSString *code=[urlStr substringFromIndex:range.location+range.length];
        [self getAccessTokenWithCode:code];
        return NO;
    }else {
     return YES;
    }
}
- (void) getAccessTokenWithCode:(NSString *)code {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *urlStr=@"https://api.weibo.com/oauth2/access_token";
    /**
     *
     必选	类型及范围	说明
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

     */
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"client_id"]=APP_KEY;
     parameters[@"client_secret"]=APP_SECRET;
     parameters[@"grant_type"]=@"authorization_code";
     parameters[@"code"]=code;
     parameters[@"redirect_uri"]=REDIRECT_URI;
  
   [manager POST:urlStr
      parameters:parameters
         success:^(AFHTTPRequestOperation * operation, NSDictionary   *responseObject) {
             WTXMAccountModel *account=[[WTXMAccountModel alloc] init];
             [account setValuesForKeysWithDictionary:responseObject];
             [WTXMAccountTool saveAccount:account];
             
             [WTXMWindowTool chooseRootViewController];
       
   } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
       NSLog(@"请求失败:%@", error);

   }];
}

@end
