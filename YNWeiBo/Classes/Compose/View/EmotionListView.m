//
//  EmotionListView.m
//  YNWeiBo
//
//  Created by james on 15/7/11.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionListView.h"
#import "Emotion.h"
#import "UIView+Extension.h"
#import "EmotionPageView.h"

@interface EmotionListView ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation EmotionListView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //1.UIScrollView
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.pagingEnabled =YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [UIPageControl new];
        //图片平铺，不够长时会拉伸
        //pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        //pageControl.pageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
        //私有变量 ，使用KOC改变值
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    //删除之新创建的
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //1.PageControl
    NSUInteger count = (emotions.count+EmotionPageSize-1)/EmotionPageSize;
    
    self.pageControl.numberOfPages = count;
    
    //2.UIScrollView 创建用来显示每一页表情的控件
    for (int i=0; i<count; i++) {
        EmotionPageView *pageView = [[EmotionPageView alloc]init];
        
        NSRange range ;
        range.location = i*EmotionPageSize;
        
        if (i==(count-1)) {
            range.length = emotions.count - range.location;
        }else{
            range.length = EmotionPageSize;
        }
        
        
        pageView.emotions = [emotions subarrayWithRange:range];
        
        [self.scrollView addSubview:pageView];
        
    }
    
    [self setNeedsLayout];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height-self.pageControl.height;
    
    self.scrollView.width= self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.y = self.scrollView.y = 0;
    
    NSUInteger count = self.scrollView.subviews.count;
    
    for (int i =0; i<count; i++) {
        EmotionPageView *pageView = self.scrollView.subviews[i];
        //禁止滚动条后，subviews个数才是自己加入的个数
        pageView.width = self.scrollView.width;
        pageView.y =0;
        pageView.x = pageView.width *i;
        pageView.height = self.scrollView.height;
    }
    
    self.scrollView.contentSize = CGSizeMake(count *self.scrollView.width, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNo = scrollView.contentOffset.x/scrollView.width;
    
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
