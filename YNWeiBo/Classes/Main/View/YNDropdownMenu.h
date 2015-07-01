//
//  YNDropdownMenu.h
//  YNWeiBo
//
//  Created by james on 15/7/1.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YNDropdownMenu;

@protocol YNDropdownMenuDelegate <NSObject>

@optional
-(void)dropdownMenuDidDismiss:(YNDropdownMenu*)menu;
-(void)dropdownMenuDidShow:(YNDropdownMenu*)menu;
@end

@interface YNDropdownMenu : UIView

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;

@property(nonatomic,strong)UIView *content;
@property(nonatomic,strong)UIViewController *contentController;
@property(nonatomic,weak)id<YNDropdownMenuDelegate> delegate;

@end
