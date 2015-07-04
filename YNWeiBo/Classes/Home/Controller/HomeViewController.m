//
//  HomeViewController.m
//  YNWeiBo
//
//  Created by james on 15/6/28.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "YNDropdownMenu.h"
#import <AFNetworking.h>
#import "AccountTool.h"
#import "TitleButton.h"

@interface HomeViewController ()<YNDropdownMenuDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    
    [self setupUserInfo];
    
    }

-(void)setupUserInfo{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"用户信息:%@",responseObject);
        
        NSString *name = responseObject[@"name"];
        
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:name forState:UIControlStateNormal];
        
        //保存呢称
        account.name= name;
        [AccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求用户信息失败:%@",error);
    }];
    
    
    
    
}

-(void)setupNav{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    // 中间标题按钮
    TitleButton *titleButton = [[TitleButton alloc]init];
    
    NSString *name = [AccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = titleButton;
    
    
    //如果按钮内容的图片，文字固定，用以下方法设置间距比较简单
    //    CGFloat titleW = titleButton.titleLabel.width;
    //    CGFloat imageW = titleButton.imageView.width;
    //    CGFloat left = titleW +imageW;
    //    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left+10, 0, 0);
    //    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);

}

- (void)titleClick:(UIButton *)titleButton {
    
    YNDropdownMenu *menu = [YNDropdownMenu menu];
    menu.delegate =self;
    menu.content = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [menu showFrom:titleButton];
    

}

-(void)dropdownMenuDidShow:(YNDropdownMenu *)menu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;

}

-(void)dropdownMenuDidDismiss:(YNDropdownMenu *)menu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

-(void)friendSearch{
    
}

-(void)pop{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


@end
