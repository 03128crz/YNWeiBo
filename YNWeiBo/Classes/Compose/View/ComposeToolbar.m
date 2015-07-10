//
//  ComposeToolbar.m
//  YNWeiBo
//
//  Created by james on 15/7/10.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "ComposeToolbar.h"
#import "UIView+Extension.h"

@implementation ComposeToolbar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted"];
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted"];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted"];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted"];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted"];
    }
    
    return self;
}

-(void)setupBtn:(NSString *)image highImage:(NSString *)highImage{
 
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置所有按钮的frame
    NSUInteger count = self.subviews.count;
    
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i*btnW;
        btn.height =btnH;
    }
}

@end
