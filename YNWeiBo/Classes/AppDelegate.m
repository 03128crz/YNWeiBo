//
//  AppDelegate.m
//  YNWeiBo
//
//  Created by james on 15/6/28.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "NewfeatureViewController.h"
#import "OAuthViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"

#ifdef DEBUG
#define YNLog(...) NSLog(__VA__ARGS__)
#else
#define YNLog(...)
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //makeKeyAndVisible 才会主窗口出现
    [self.window makeKeyAndVisible];
    
    //帐号处理
    Account *account = [AccountTool account];
    
    if (account) {
            [self.window switchRootViewController];
    }else{
        self.window.rootViewController = [[OAuthViewController alloc]init];
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //取消下载
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    //清除内存中的所有图片
    [mgr.imageCache clearMemory];
}

@end
