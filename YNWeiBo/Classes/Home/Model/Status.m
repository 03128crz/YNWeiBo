//
//  Status.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"
#import "Photo.h"
@implementation Status

-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[Photo class]};
}


@end
