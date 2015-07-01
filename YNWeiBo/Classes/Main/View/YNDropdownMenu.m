//
//  YNDropdownMenu.m
//  YNWeiBo
//
//  Created by james on 15/7/1.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "YNDropdownMenu.h"
#include "UIView+Extension.h"

@interface YNDropdownMenu ()
@property(nonatomic)UIImageView *containerView;

@end

@implementation YNDropdownMenu

-(UIImageView *)containerView{
    if (_containerView==nil) {
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
        
    }
    
    return _containerView;
}

-(void)setContent:(UIView *)content{
    _content = content;
    //调整内容的位置
    _content.x =10;
    _content.y =15;
    
    //设置灰色的调度
    self.containerView.height = CGRectGetMaxY(content.frame)+10;
    //固定内容的宽度
    //content.width = self.containerView.width - 2*content.x;
    self.containerView.width = CGRectGetMaxX(content.frame)+10;
    
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
    

}

-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    
    self.content = contentController.view;
}

-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        

    }
    
    return self;
}

+(instancetype)menu{
  
    return [[self alloc]init];
}

-(void)showFrom:(UIView *)from{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    //调整灰色图片的位置
    
    //默认情况下，frame是以父控件左上角为坐标原点
    //可以转换坐标系原点,改变frame的参照点
    //转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX  = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

-(void)dismiss{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
