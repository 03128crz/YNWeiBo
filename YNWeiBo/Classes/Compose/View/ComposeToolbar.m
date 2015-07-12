//
//  ComposeToolbar.m
//  YNWeiBo
//
//  Created by james on 15/7/10.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "ComposeToolbar.h"
#import "UIView+Extension.h"

@interface ComposeToolbar ()

@property (weak, nonatomic) UIButton *emotionButton;

@end

@implementation ComposeToolbar

-(void)setShowKeyboardButton:(BOOL)showKeyboardButton{
    _showKeyboardButton = showKeyboardButton;
    
    if (_showKeyboardButton) {
        
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        
    }else{
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:ComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:ComposeToolbarButtonTypePicture];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:ComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:ComposeToolbarButtonTypeTrend];
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:ComposeToolbarButtonTypeEmotion];
    }
    
    return self;
}

-(UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(ComposeToolbarButtonType)type{
 
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    
    return btn;
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

-(void)btnClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        //NSUInteger index = (NSUInteger)(btn.x/btn.width);
        
        [self.delegate composeToolbar:self didClickButton:(int)btn.tag];
    }
}

@end
