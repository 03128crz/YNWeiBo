//
//  EmotionPopView.m
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionPopView.h"
#import "Emotion.h"
#import "UIView+Extension.h"
#import "EmotionButton.h"

@interface EmotionPopView ()
@property (weak, nonatomic) IBOutlet EmotionButton *emotionButton;

@end

@implementation EmotionPopView

+(instancetype)popView{
    
    
    return [[[NSBundle mainBundle] loadNibNamed:@"EmotionPopView" owner:nil options:nil] lastObject];
}


-(void)showFrom:(EmotionButton *)button{
    
    if (button ==nil) {
        return;
    }
    
    self.emotionButton.emotion = button.emotion;
    
    UIWindow *windows =  [[UIApplication sharedApplication].windows lastObject];
    
    [windows addSubview:self];
    //    self.popView.y = btn.centerY-self.popView.height;
    //    self.popView.centerX = btn.centerX;
    //转换坐标系
    
    //计算出被点击的按钮在windows的frame
    CGRect frame = [button convertRect:button.bounds toView:windows];
    self.y = CGRectGetMidY(frame)-self.height;
    self.centerX = CGRectGetMidX(frame);
 
}

@end
