//
//  TitleButton.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "TitleButton.h"
#import "UIView+Extension.h"

@implementation TitleButton

-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        //设置内容居中
        //self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    
    return self;
}

//可以在layoutSubviews中重排布局
//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width = 13;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    CGFloat x = 0;
//    CGFloat y = 0;
//    
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    
//    
//    CGFloat width = 80;
//    CGFloat height = contentRect.size.height;
//    
//    
//    
//    return CGRectMake(x, y, width, height);
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    //如果仅仅是调整按钮内部的位置，在layoutSubviews中单独设置位置即可
    //1.计算titleLabel
    self.titleLabel.x = self.imageView.x;
    //2.计算imageView
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
