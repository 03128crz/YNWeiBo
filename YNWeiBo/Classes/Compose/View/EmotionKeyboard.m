//
//  EmotionKeyboard.m
//  YNWeiBo
//
//  Created by james on 15/7/11.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionKeyboard.h"
#import "EmotionListView.h"
#import "EmotionTabBar.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "Emotion.h"

@interface EmotionKeyboard ()<EmotionTabBarDelegate>
/** 容纳表情控件*/
@property (weak, nonatomic) UIView *contentView;
@property (strong, nonatomic) EmotionListView *recentListView;
@property (strong, nonatomic) EmotionListView *defaultListView;
@property (strong, nonatomic) EmotionListView *emojiListView;
@property (strong, nonatomic) EmotionListView *lxhListView;
@property (weak, nonatomic) EmotionTabBar *tabBar;

@end

@implementation EmotionKeyboard


-(EmotionListView *)recentListView{
    if (!_recentListView) {
        self.recentListView = [[EmotionListView alloc] init];
    }
    
    return _recentListView;
}

-(EmotionListView *)defaultListView{
    if (!_defaultListView) {
        self.defaultListView = [[EmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultEmotions = [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.defaultListView.emotions = defaultEmotions;
    }
    
    return _defaultListView;
}

-(EmotionListView *)emojiListView{
    if (!_emojiListView) {
        self.emojiListView = [[EmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions = [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];;
        self.emojiListView.emotions = emojiEmotions;
    }
    
    return _emojiListView;
}

-(EmotionListView *)lxhListView{
    if (!_lxhListView) {
        self.lxhListView = [[EmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];;
        self.lxhListView.emotions = lxhEmotions;
    }
    
    return _lxhListView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *content = [UIView new];
        [self addSubview:content];
        self.contentView  = content;
        
        EmotionTabBar *tabBar = [[EmotionTabBar alloc]init];
        tabBar.delegate = self;

        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.tabBar.height = 37;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.x = 0;
    self.tabBar.width = self.width;
    
    self.contentView.x = self.contentView.y = 0;
    self.contentView.height = self.tabBar.y;
    self.contentView.width = self.width;
    
    //设置尺寸
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
    
}

-(void)emotionTabBar:(EmotionTabBar *)tabBar didSelectButton:(EmotionTabBarButtonType)buttonType{
    
    //移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //切换
    switch (buttonType) {   
        case EmotionTabBarButtonTypeRecent:{
            [self.contentView addSubview:self.recentListView];
            break;
        }
        case EmotionTabBarButtonTypeDefault:{
            //默认在xxx.app 根目录中找文件，所以要加上目录目径
            [self.contentView addSubview:self.defaultListView];
            break;
        }
        case EmotionTabBarButtonTypeEmoji:{
            [self.contentView addSubview:self.emojiListView];
            break;
        }
        case EmotionTabBarButtonTypeLxh:{
            [self.contentView addSubview:self.lxhListView];
            break;
        }
        default:
            break;
    }
  
    //重新计算子控件的frame,会在恰当的时刻，重新调用layoutSubviews
    [self setNeedsLayout];
}

@end
