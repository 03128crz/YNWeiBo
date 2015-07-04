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
#import "UIImageView+WebCache.h"
#import "Status.h"
#import "User.h"
#import "MJExtension.h"

@interface HomeViewController ()<YNDropdownMenuDelegate>
/** */
@property(nonatomic,strong)NSMutableArray *statuses;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUserInfo];
    
    [self loadNewStatus];
    
    _statuses = [NSMutableArray array];
    
}

-(void)setupUserInfo{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        User *user = [User objectWithKeyValues:responseObject];

        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //保存呢称
        account.name= user.name;
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

-(void)loadNewStatus{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;

    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"最新动态:%@",responseObject);
        
//        NSArray *dictArray = responseObject[@"statuses"];
//        
//        for (NSDictionary *dict in dictArray) {
//            Status *status = [Status objectWithKeyValues:dict];
//            [self.statuses addObject:status];
//        }
        
        self.statuses =[Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"请求最新动态失败:%@",error);
    }];
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"status";
    Status *status = [self.statuses objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    User *user = status.user;
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}


@end
