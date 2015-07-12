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

@interface EmotionKeyboard ()<EmotionTabBarDelegate>

@property (weak, nonatomic) EmotionListView *listView;
@property (weak, nonatomic) EmotionTabBar *tabBar;

@end

@implementation EmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        EmotionListView *listView = [[EmotionListView alloc]init];
        [self addSubview:listView];
        self.listView = listView;
        
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
    
    self.listView.x = self.listView.y = 0;
    self.listView.height = self.tabBar.y;
    self.listView.width = self.width;
}

-(void)emotionTabBar:(EmotionTabBar *)tabBar didSelectButton:(EmotionTabBarButtonType)buttonType{
    
    switch (buttonType) {
        case EmotionTabBarButtonTypeRecent:
            
            break;
        case EmotionTabBarButtonTypeDefault:
            
            break;
        case EmotionTabBarButtonTypeEmoji:
            
            break;
        case EmotionTabBarButtonTypeLxh:
            
            break;
        default:
            break;
    }
}

@end
