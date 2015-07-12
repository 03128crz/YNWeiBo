//
//  EmotionTabBar.h
//  YNWeiBo
//
//  Created by james on 15/7/11.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EmotionTabBarButtonTypeRecent,
    EmotionTabBarButtonTypeDefault,
    EmotionTabBarButtonTypeEmoji,
    EmotionTabBarButtonTypeLxh
}EmotionTabBarButtonType;

@class EmotionTabBar;
@protocol EmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(EmotionTabBar *)tabBar didSelectButton:(EmotionTabBarButtonType)buttonType;
@end

@interface EmotionTabBar : UIView
@property (weak, nonatomic) id<EmotionTabBarDelegate> delegate;

@end
