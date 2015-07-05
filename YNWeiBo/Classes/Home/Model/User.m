//
//  User.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "User.h"

@implementation User

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    
    self.vip = mbtype >2;
}
//
//-(BOOL)isVip{
//    return self.mbrank>2;
//}

@end
