//
//  Status.h
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject

@property (nonatomic,copy)NSString *idstr;

@property (nonatomic,copy)NSString *text;

@property (nonatomic,strong)User *user;

@property (nonatomic,copy)NSString *created_at;

@property (nonatomic,copy)NSString *source;

@property (nonatomic,strong)NSArray *pic_urls;

/** 被转发的微博 */
@property (nonatomic,strong)Status *retweeted_status;

/** 转发数 */
@property(nonatomic,assign)int reposts_count;
/** 评论数 */
@property(nonatomic,assign)int comments_count;
/** 表态数 */
@property(nonatomic,assign)int attitudes_count;

@end
