//
//  EmotionButton.m
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionButton.h"
#import "Emotion.h"
#import "NSString+Emoji.h"

@implementation EmotionButton

//当控件不是从xib、storyboard创建时，就会调用这个方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        //长按高亮不调整图片
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

//当控件从xib、storyboard创建时，就会调用这个方法
-(id)initWithCoder:(NSCoder *)coder{
    if (self=[super initWithCoder:coder]) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];

    }
    
    return self;
}

//这个方法在initWithCoder方法调用后调用
-(void)awakeFromNib{
    
}

-(void)setEmotion:(Emotion *)emotion{
    
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else{
        //emotion.code : 十六进制 -->Emoji 字符
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }
}

@end
