//
//  UITextView+Extension.m
//  YNWeiBo
//
//  Created by james on 15/7/13.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)text{
    
    [self insertAttributeText:text settingBlock:nil];

}

-(void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock{
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc]init];
    //拼接之前的文字，（图片和普通文字）
    [attrText appendAttributedString:self.attributedText];
    
    NSUInteger loc = self.selectedRange.location;
    //加到光标所在位置的后面
    //[attrText insertAttributedString:text atIndex:loc];
    //光标多选替换
    [attrText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    //调用外面传进来的代码 ，要先判断不是为nil
    if (settingBlock) { //把attText传到外面去
        settingBlock(attrText);
    }
    
    self.attributedText = attrText;//光标会自动移到最后
    
    //重新设置光标位置支插入表情的后面
    self.selectedRange = NSMakeRange(loc+1, 0);
    
}

@end
