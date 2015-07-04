//
//  AccountTool.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "AccountTool.h"
#import "Account.h"

@implementation AccountTool

+(void)saveAccount:(Account *)account{
    
    //获取帐号存储的时间（accessToken产生时间）
    account.created_time =[NSDate date];
    //[responseObject writeToFile:path atomically:YES];
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}

+(Account *)account{
    
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    //验证帐号是否过期
    long long expires_in = [account.expires_in longLongValue];
    NSDate *expiresTime =  [account.created_time dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    //如果now >= expiresTime ,过期
    NSComparisonResult result =  [expiresTime compare:now];
    
    if (!result == NSOrderedDescending) {//过期
        return  nil;
    }
    
    return account;
}

@end
