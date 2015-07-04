//
//  Account.h
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

@property (nonatomic,copy)NSString *access_token;
@property (nonatomic,copy)NSNumber *expires_in;
@property (nonatomic,copy)NSString *uid;
@property (nonatomic,strong)NSDate *created_time;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
