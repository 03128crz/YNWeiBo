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


+(void)addRecentEmotion:(Emotion *)emotion{
    
    NSMutableArray *emotions = (NSMutableArray*)[self recentEmotions];
    if (emotions ==nil) {
        emotions = [NSMutableArray array];
    }

    [emotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:emotions toFile:RecentEmotionsPath];
    
}

+(NSArray *)recentEmotions{

    return [NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionsPath];

}

@end
