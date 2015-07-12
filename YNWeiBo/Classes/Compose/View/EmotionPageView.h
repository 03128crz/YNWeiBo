//
//  EmotionPageView.h
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PageViewInset 10
#define EmotionMaxCols 7
#define EmotionMaxRows 3

#define EmotionPageSize ((EmotionMaxCols * EmotionMaxRows)-1)

@interface EmotionPageView : UIView

@property (strong, nonatomic) NSArray *emotions;

@end
