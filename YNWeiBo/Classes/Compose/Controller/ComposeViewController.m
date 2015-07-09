//
//  ComposeViewController.m
//  YNWeiBo
//
//  Created by james on 15/7/9.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "ComposeViewController.h"
#import "AccountTool.h"
#import "UIView+Extension.h"
#import "YNTextView.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"

@interface ComposeViewController ()

@property (weak, nonatomic) YNTextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupTextView];
    

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
UITextField:
 文字只有一行
 有placehoder
 继承处UIControl
 监听行为
   1.设置代理
    2.addTarget:action:forControlEvents:
    3.通知 UItextFieldTextDidChangeNotification
 
UITextView
 多行
 不能设置占位文字
 继承自ScrollView
 监听行为
   1.设置代理
   2.通知 UItextViewTextDidChangeNotification
 **/


-(void)setupTextView{
    
    //继承自ScrollView，设置了内边距，可以在导航栏下才开始输出文字
    //其它控件如buttom直接添加，会被导航栏挡住
    YNTextView *textView = [[YNTextView alloc]init];
    //占据整个屏幕
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享你的新鲜事...";
    [self.view addSubview:textView];
    
        self.textView = textView;
    
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleView = [[UILabel alloc]init];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.numberOfLines = 0;
    titleView.height =44;
    NSString *name = [AccountTool account].name;
    
    NSString *str = [NSString stringWithFormat:@"发微博\n%@",name];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15 ] range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 ] range:[str rangeOfString:name]];
    
    titleView.attributedText = attrStr;
    
    
    self.navigationItem.titleView  =titleView;
    

}

#pragma mark - event response

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"]= self.textView.text;
  
    
    [mgr POST:@"https://api.weibo.com/oauth2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"请求成功-%@",responseObject);

        [MBProgressHUD showSuccess:@"发送成功"];
        
        //自定义状态栏，显示api返回的信息
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败-%@",error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)textDidChange{
    
    self.navigationItem.rightBarButtonItem.enabled  = self.textView.hasText;
}

@end
