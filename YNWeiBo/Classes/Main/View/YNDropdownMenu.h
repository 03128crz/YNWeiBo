//
//  YNDropdownMenu.h
//  YNWeiBo
//
//  Created by james on 15/7/1.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNDropdownMenu : UIView

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;

@property(nonatomic,strong)UIView *content;
@property(nonatomic,strong)UIViewController *contentController;

@end
