//
//  UIBarButtonItem+Extension.h
//  YNWeiBo
//
//  Created by james on 15/6/29.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString*)highImage;

@end
