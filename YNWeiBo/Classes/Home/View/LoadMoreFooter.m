//
//  LoadMoreFooter.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "LoadMoreFooter.h"

@implementation LoadMoreFooter

+(instancetype)footer{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
