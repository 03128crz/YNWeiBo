//
//  NewfeatureViewController.m
//  YNWeiBo
//
//  Created by james on 15/7/2.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "UIView+Extension.h"
#import "MainTabBarController.h"
#define YNNewfeatureCount 4

@interface NewfeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic) UIPageControl *pageControl;
@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    
    [self.view addSubview:scrollView];
    CGFloat scrollW = scrollView.width;
    
    for (int i; i<YNNewfeatureCount; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.width = scrollView.width;
        imageView.height = scrollView.height;
        imageView.y =0;
        imageView.x = i*scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        if (i==YNNewfeatureCount-1) {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(YNNewfeatureCount*scrollW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;//取消弹簧效果
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [UIPageControl new];
    //pageControl.width = 100;
    //pageControl.height = 50;//这个控件特殊，不用设置高度也可以显示
    //pageControl.userInteractionEnabled = NO;
    pageControl.currentPageIndicatorTintColor  = [UIColor greenColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.numberOfPages = YNNewfeatureCount;
    pageControl.centerX = scrollView.width* 0.5;
    pageControl.centerY = scrollView.height -50;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x /scrollView.width;
    self.pageControl.currentPage = (int)(page+0.5);//四舍五入
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setupLastImageView:(UIImageView*)imageView{
    
    imageView.userInteractionEnabled = YES;
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width *0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    [imageView addSubview:shareBtn];
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.size = startBtn.currentBackgroundImage.size;
    
    startBtn.centerX = imageView.width *0.5;
    startBtn.centerY = imageView.height * 0.75;
    
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView addSubview:startBtn];
}

-(void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.selected;
}

-(void)startClick{
    //切换到首页
    /*
     1.push
     2.modal
     3.切换rootController
     */
    [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarController alloc] init];
     
     
}

@end
