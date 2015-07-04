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
    
    [self setuprefresh];
    
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

-(void)setuprefresh{
    UIRefreshControl *control = [UIRefreshControl new];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //仅仅显示刷新状态,
    [control beginRefreshing];
    [self refreshStateChange:control];
}

-(void)refreshStateChange:(UIRefreshControl *)control{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //只刷新最新的
    Status *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    params[@"access_token"] = account.access_token;
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newStatues = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range = NSMakeRange(0, newStatues.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatues atIndexes:set];
        [self.tableView reloadData];
        [control endRefreshing];
        [self showNewStatusCount:newStatues.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        [control endRefreshing];
    }];
}

-(void)showNewStatusCount:(int)count{
    UILabel *label  = [UILabel new];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height =30 ;
    
    if (count==0) {
        label.text = @"没有新的微博数据";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.y = 64-label.height;
    label.textAlignment = NSTextAlignmentCenter;
    //添加到导航控件的下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        //label.y +=label.height;
        //或者
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //延时
        [UIView animateWithDuration:1.0 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            //label.y -=label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
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
