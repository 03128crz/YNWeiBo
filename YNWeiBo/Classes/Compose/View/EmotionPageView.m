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

@interface EmotionPageView ()

@end

@implementation EmotionPageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
    }
    
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i =0; i<count; i++) {
        UIButton *btn = [UIButton new];
        
        Emotion *emotion = emotions[i];
        if (emotion.png) {
              [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        }else{
             //emotion.code : 十六进制 -->Emoji 字符
            [btn setTitle:[emotion.code emoji] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        
        [self addSubview:btn];
    }
    
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
