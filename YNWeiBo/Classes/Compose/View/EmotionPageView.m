//
//  EmotionPageView.m
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionPageView.h"
#import "Emotion.h"
#import "UIView+Extension.h"
#import "NSString+Emoji.h"
#import "EmotionPopView.h"
#import "UIView+Extension.h"
#import "EmotionButton.h"

@interface EmotionPageView ()
/** 表情放大镜*/
@property (strong, nonatomic) EmotionPopView *popView;
@property (weak, nonatomic) UIButton *deleteButton;
@end

@implementation EmotionPageView

-(EmotionPopView *)popView{
    if (!_popView) {
        self.popView = [EmotionPopView popView];
        
    }
    
    return _popView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *deleteButton =[UIButton new];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        
        [self addSubview:deleteButton];
        
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.deleteButton = deleteButton;
        
        
        
    }
    
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i =0; i<count; i++) {
        EmotionButton *btn = [EmotionButton new];
        [self addSubview:btn];
        
        btn.emotion= emotions[i];

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)deleteClick{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidDeleteNotification" object:nil userInfo:nil];
}

-(void)btnClick:(EmotionButton *)btn{

   UIWindow *windows =  [[UIApplication sharedApplication].windows lastObject];
    
    [windows addSubview:self.popView];
//    self.popView.y = btn.centerY-self.popView.height;
//    self.popView.centerX = btn.centerX;
    //转换坐标系
    
    //计算出被点击的按钮在windows的frame
    CGRect frame = [btn convertRect:btn.bounds toView:windows];
    self.popView.y = CGRectGetMidY(frame)-self.popView.height;
    self.popView.centerX = CGRectGetMidX(frame);
    
    self.popView.emotion = btn.emotion;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectEmotionKey"] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidSelectNotification" object:nil userInfo:userInfo];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width-2*PageViewInset)/EmotionMaxCols;
    CGFloat btnH= (self.height-1*PageViewInset)/EmotionMaxRows;//不要下边的间距
    
    for (int i =0; i<count; i++) {
        
        
        UIButton *btn = self.subviews[i+1];//加1是因为删除按钮在第一个
        btn.width = btnW;
        btn.height = btnH;
        
        btn.x = PageViewInset +(i%7)*btnW;
        btn.y = PageViewInset +(i/7)*btnH;
        
    }
    
    //每页都有个删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width-PageViewInset-btnW;
    self.deleteButton.y = self.height - btnH;
    
}

@end
