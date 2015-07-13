//
//  EmotionTextView.h
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "YNTextView.h"
@class Emotion;
@interface EmotionTextView : YNTextView

-(void)insertEmotion:(Emotion *)emotion;

-(NSString *)fullText;

@end
