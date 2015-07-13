//
//  EmotionAttachment.h
//  YNWeiBo
//
//  Created by james on 15/7/13.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emotion;
@interface EmotionAttachment : NSTextAttachment

@property (strong, nonatomic) Emotion *emotion;

@end
