//
//  EmotionAttachment.m
//  YNWeiBo
//
//  Created by james on 15/7/13.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionAttachment.h"
#import "Emotion.h"
@implementation EmotionAttachment

-(void)setEmotion:(Emotion *)emotion{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];;
    
}

@end
