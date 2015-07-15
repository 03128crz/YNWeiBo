//
//  EmotionTool.m
//  YNWeiBo
//
//  Created by james on 15/7/15.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionTool.h"
#import "Emotion.h"

#define RecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

@implementation EmotionTool

static NSMutableArray *_recentEmotions;

+(void)initialize{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionsPath];
    if (_recentEmotions ==nil) {
         _recentEmotions = [NSMutableArray array];
    }
}

+(void)addRecentEmotion:(Emotion *)emotion{
    

    //[emotions removeObject:emotion]; //内存地址
    //方法一
//    for (int i=0; i<emotions.count; i++) {
//        
//        Emotion *e = emotions[i];
//        
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;//remove后直接跳出
//        }
//        
//    }
    //方法二、重写Emotion 的isEqual方法,判断 chs 和 code 是否一样
    [_recentEmotions removeObject:emotion];

    
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:RecentEmotionsPath];
    
}

+(NSArray *)recentEmotions{

    return _recentEmotions;

}

@end
