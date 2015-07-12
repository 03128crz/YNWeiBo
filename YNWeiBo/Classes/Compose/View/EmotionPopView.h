//
//  EmotionPopView.h
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emotion;
@interface EmotionPopView : UIView

+(instancetype)popView;

@property (strong, nonatomic) Emotion *emotion;

@end
