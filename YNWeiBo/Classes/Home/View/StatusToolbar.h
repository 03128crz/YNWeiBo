//
//  StatusToolbar.h
//  YNWeiBo
//
//  Created by james on 15/7/5.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;
@interface StatusToolbar : UIView

+(instancetype)toolbar;

@property(nonatomic,strong)Status *status;

@end
