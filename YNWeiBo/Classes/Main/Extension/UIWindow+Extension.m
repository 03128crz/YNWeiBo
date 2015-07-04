//
//  UIWindow+Extension.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MainTabBarController.h"
#import "NewfeatureViewController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController{
    
    NSString *key =@"CFBundleVersion";
    //存储在沙盒中的版本号（上一次的使用版本）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号(当前软件版本) Info.plist
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[MainTabBarController alloc] init];
    }else{
        self.rootViewController = [NewfeatureViewController new];
        //将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
