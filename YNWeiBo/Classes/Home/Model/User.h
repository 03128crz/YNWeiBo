//
//  User.h
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UserVerifiedTypeNone = -1,
    UserVerifiedTypePersonal= 0,
    UserVerifiedTypeOrgEnterprice = 2,
    UserVerifiedTypeOrgMedia = 3,
    UserVerifiedTypeOrgWebsite = 5,
    UserVerifiedTypeDaren = 220
    
}UserVerifiedType;

@interface User : NSObject

@property (nonatomic,copy)NSString *idstr;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *profile_image_url;

/** 会员类型 值>2，才代表是会员 */
@property (nonatomic,assign) int mbtype;
//会员等级
@property (nonatomic,assign) int mbrank;

@property (nonatomic,assign,getter=isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic,assign)UserVerifiedType verified_type;

@end
