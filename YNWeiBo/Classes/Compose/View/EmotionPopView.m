//
//  EmotionPopView.m
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionPopView.h"
#import "Emotion.h"
#import "EmotionButton.h"

@interface EmotionPopView ()
@property (weak, nonatomic) IBOutlet EmotionButton *emotionButton;

@end

@implementation EmotionPopView

+(instancetype)popView{
    
    
    return [[[NSBundle mainBundle] loadNibNamed:@"EmotionPopView" owner:nil options:nil] lastObject];
}

-(void)setEmotion:(Emotion *)emotion{
    _emotion = emotion;
    
    self.emotionButton.emotion = emotion;
    
}

@end
