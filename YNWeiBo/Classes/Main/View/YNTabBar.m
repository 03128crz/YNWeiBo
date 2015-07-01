//
//  YNTabBar.m
//  YNWeiBo
//
//  Created by james on 15/7/1.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "YNTabBar.h"
#import "UIView+Extension.h"

@interface YNTabBar ()
@property(nonatomic,weak)UIButton *addBtn;
@end

@implementation YNTabBar

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //添加一个按钮到tabbar中
        UIButton *addBtn = [[UIButton alloc] init];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        addBtn.size = addBtn.currentBackgroundImage.size;
        
        [addBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:addBtn];
        
        self.addBtn = addBtn;
    }
    return self;
}

-(void)plusClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews ];
    
    NSLog(@"%f",self.width);
    
    self.addBtn.centerX = self.width * 0.5;
    self.addBtn.centerY = self.height * 0.5;
    
    CGFloat tabbarButtonW = self.width/5;
    CGFloat tabarButtonIndex = 0;
    
    int count =7;
    
    for (int i=0; i<count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabarButtonIndex *75;
            tabarButtonIndex++;
            if (tabarButtonIndex==2) {
                tabarButtonIndex ++;
            }
        }
    }
}

@end
