//
//  UIBarButtonItem+Extension.m
//  YNWeiBo
//
//  Created by james on 15/6/29.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)


+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString*)highImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
