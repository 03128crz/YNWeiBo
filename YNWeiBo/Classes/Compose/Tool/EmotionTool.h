//
//  EmotionTool.h
//  YNWeiBo
//
//  Created by james on 15/7/15.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Emotion;
@interface EmotionTool : NSObject

+(void)addRecentEmotion:(Emotion *)emotion;

+(NSArray *)recentEmotions;

@end
