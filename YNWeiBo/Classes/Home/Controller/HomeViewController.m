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
#import "LoadMoreFooter.h"
#import "StatusCell.h"
#import "StatusFrame.h"

@interface HomeViewController ()<YNDropdownMenuDelegate>
/** */
@property(nonatomic,strong)NSMutableArray *statuseFrames;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    //self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    [self setupNav];
    
    [self setupUserInfo];
    
    [self setupDownRefresh];
    
    [self setupUpRefresh];
    
    //在主线程中，如果一直滚动不会触发
    //程序进入后台，定时器会暂停运行
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //主线程抽时间处理timer
    //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    _statuseFrames = [NSMutableArray array];
    
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

-(void)setupDownRefresh{
    UIRefreshControl *control = [UIRefreshControl new];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //仅仅显示刷新状态,
    [control beginRefreshing];
    [self refreshStateChange:control];
}

-(void)setupUpRefresh{
    
    LoadMoreFooter *footer = [LoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
}

-(void)setupUnreadCount{
    
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       //int unreadCount= [responseObject[@"status"] intValue];
        //self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadCount];
        //@20 --> @"20"
        NSString *unReadCount =[responseObject[@"status"] description ];
        if ([unReadCount isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            //需要用户授权
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = [responseObject[@"status"] description ];
            [UIApplication sharedApplication].applicationIconBadgeNumber = [unReadCount intValue];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求未读娄错误:%@",error);
    }];
}

-(void)refreshStateChange:(UIRefreshControl *)control{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //只刷新最新的
    StatusFrame *firstStatusF = [self.statuseFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    params[@"access_token"] = account.access_token;
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newStatues = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFramesWithStatuses:newStatues];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuseFrames insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
        [control endRefreshing];
        [self showNewStatusCount:newStatues.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        [control endRefreshing];
    }];
}

-(void)loadMoreStatus{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //取出最后面的
    StatusFrame *lastStatusF = [self.statuseFrames lastObject];
    if (lastStatusF) {
        long long maxId = lastStatusF.status.idstr.longLongValue -1;
        params[@"max_id"] = @(maxId);
    }
    params[@"access_token"] = account.access_token;

    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newsStatuses = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFramesWithStatuses:newsStatuses];
        
        [self.statuseFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载更多数据失败:%@",error);
        self.tableView.tableFooterView.hidden = YES;
    }];
}

-(void)showNewStatusCount:(int)count{
    
    self.tabBarItem.badgeValue = nil;
    
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
    
    //如果某个动画执行完毕后，又要回到之前状态，建议用transform
    [UIView animateWithDuration:1.0 animations:^{
        //label.y +=label.height;
        //或者
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //延时 停留1s后再用1s时间回到原来位置，完成后remove
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

    return self.statuseFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statuseFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrame *frame = self.statuseFrames[indexPath.row];
    return frame.cellHeight;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.statuseFrames.count==0 || self.tableView.tableFooterView.isHidden==NO) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom-scrollView.height-self.tableView.tableFooterView.height;
    if (offsetY>=judgeOffsetY) {
        self.tableView.tableFooterView.height=NO;
        [self loadMoreStatus];
    }
}

//将Statuss模型转为StatusFrame模型
-(NSArray *)statusFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray *frames =[NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *f = [StatusFrame new];
        f.status = status;
        [frames addObject:f];
    }
    
    return frames;
}

@end
