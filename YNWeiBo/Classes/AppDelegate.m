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

    //死亡状态
    //前台运行
    //后台暂停 停止一切动画、定时器、多媒体操作、联网
    //后台运行
    
    //向操作系统申请后台运行的资格，能维持多外，是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已结束，就会调用这个block
        [application endBackgroundTask:task];
        
    }];
    
    //在info.plist 中设置后台模式：Required background modes ＝＝ App plays audio or streams audio/video using AirPlay
    //搞一个0kb的mp3，没有声音，循环播放，保证应用在后台时存留时间长此
    
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
