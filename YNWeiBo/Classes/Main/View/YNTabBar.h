//
//  YNTabBar.h
//  YNWeiBo
//
//  Created by james on 15/7/1.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YNTabBar;

@protocol YNTabBarDelegate <UITabBarDelegate>

-(void)tabBarDidClickPlusButton:(YNTabBar *)tabBar;

@end

@interface YNTabBar : UITabBar

@property(nonatomic) id<YNTabBarDelegate> delegate;

@end
