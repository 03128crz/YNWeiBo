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
        
        
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:) ] ];
        
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

-(EmotionButton *)emotionButtonWithLocation:(CGPoint)location{
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        EmotionButton *btn = self.subviews[i+1];
        if (CGRectContainsPoint(btn.frame, location)) {
            
            return btn;
        }
    }
    
    return nil;

}

-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer{
    
    CGPoint location = [recognizer locationInView:self];
    
    EmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            //手指已经不再触摸pageView
            [self.popView removeFromSuperview];
            //如果手指还在表情按钮上，发通知给controller插入表情
            if (btn) {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[@"selectEmotionKey"] = btn.emotion;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidSelectNotification" object:nil userInfo:userInfo];
            }
            
            break;
        }
        case UIGestureRecognizerStateBegan://刚检测到长按
        case UIGestureRecognizerStateChanged:{//手指位置改变
            [self.popView showFrom:btn];
            
            break;
        }
        default:
            break;
    }
    

}

-(void)deleteClick{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidDeleteNotification" object:nil userInfo:nil];
}

-(void)btnClick:(EmotionButton *)btn{

    [self.popView showFrom:btn];
    
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
