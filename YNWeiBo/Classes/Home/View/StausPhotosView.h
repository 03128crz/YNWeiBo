//
//  StausPhotosView.h
//  YNWeiBo
//
//  Created by james on 15/7/7.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StausPhotosView : UIView

@property(nonatomic,copy)NSArray *photos;

+(CGSize)sizeWithCount:(NSInteger)count;

@end
