//
//  AccountTool.h
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;

@interface AccountTool : NSObject

+(void)saveAccount:(Account *)account;
+(Account *)account;

@end
