//
//  OAuthViewController.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "MainTabBarController.h"
#import "NewfeatureViewController.h"
#import "Account.h"
#import "MBProgressHUD+MJ.h"
#import "AccountTool.h"
#import "UIWindow+Extension.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2805419419&redirect_uri=http://"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载数据中"];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp
{
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length!=0) {
        int fromIndex = range.location +range.length;
        
        NSString *code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        //禁止加载回调地址
        return NO;
    }
    return YES;
    
}

-(void)accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //mgr.responseSerializer = [AFJSONRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2805419419";
    params[@"client_secret"]= @"e9fc234e3a61b0050d6e405779119e92";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"]=@"http://";
    params[@"code"]=code;
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"请求成功-%@",responseObject);
        [MBProgressHUD hideHUD];
        Account *account = [Account accountWithDict:responseObject];
        
        [AccountTool saveAccount:account];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
        [MBProgressHUD hideHUD];
    }];
}

@end
