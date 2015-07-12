//
//  EmotionTabBar.m
//  YNWeiBo
//
//  Created by james on 15/7/11.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionTabBar.h"
#import "UIView+Extension.h"

@interface EmotionTabBar()
@property (weak, nonatomic) UIButton *selectedBtn;
@end

@implementation EmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:EmotionTabBarButtonTypeRecent];
        UIButton *defaultBtn = [self setupBtn:@"默认" buttonType:EmotionTabBarButtonTypeDefault];
        [self btnClick:defaultBtn];
        [self setupBtn:@"Emoji" buttonType:EmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:EmotionTabBarButtonTypeLxh];
        
    }
    
    return self;
}

-(UIButton *)setupBtn:(NSString *)titile buttonType:(EmotionTabBarButtonType)buttonType{
    
    UIButton *btn = [UIButton new];
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [btn setTitle:titile forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:btn];
    
    NSString *image =@"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count ==1) {
                image =@"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count ==4){
        image =@"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";

    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal  ];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled  ];
    
    return btn;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    
    for (int i =0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y=0;
        btn.x = i*btnW;
        btn.height = btnH;
        btn.width = btnW;
    }
    
}

-(void)btnClick:(UIButton *)btn{
    
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(int)btn.tag];
    }
}

@end
