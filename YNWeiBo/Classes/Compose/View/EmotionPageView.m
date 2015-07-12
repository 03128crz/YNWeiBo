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
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width-2*PageViewInset)/EmotionMaxCols;
    CGFloat btnH= (self.height-1*PageViewInset)/EmotionMaxRows;//不要下边的间距
    
    for (int i =0; i<count; i++) {
        
        
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        
        btn.x = PageViewInset +(i%7)*btnW;
        btn.y = PageViewInset +(i/7)*btnH;
        
    }
}

@end
