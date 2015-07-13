//
//  YNTextView.m
//  YNWeiBo
//
//  Created by james on 15/7/9.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "YNTextView.h"
#import "UIView+Extension.h"

@implementation YNTextView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    
    if (self) {
       
        //默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        //不要设置自己的delegate为自己，会被外部轻易覆盖,只能设置一个代理
        //self.delegate = self;
        //可以有多个通知
        //当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//通过代码修改text不会触发以下代码
-(void)textDidChange{
    
    //重绘（重新调用drawRect）会清除以前的
    //会在下一个消息循环才调用drawRect
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    if (!self.placeholder) return;
    
    //会画出屏幕范围
    //[self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2*x;
    CGFloat y = 8;
    CGFloat h =rect.size.width - 2*y ;
    //使用drawInRect 指定范围
    [self.placeholder drawInRect:CGRectMake(x, y, w, h) withAttributes:attrs];
    
}

-(void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    
    [self setNeedsDisplay];
    
    [super setText:text];

}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [self setNeedsDisplay];
    [super setAttributedText:attributedText];
}


@end
