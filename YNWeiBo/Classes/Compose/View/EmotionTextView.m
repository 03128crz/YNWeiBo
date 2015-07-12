//
//  EmotionTextView.m
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "EmotionTextView.h"
#import "Emotion.h"
#import "NSString+Emoji.h"

@implementation EmotionTextView

-(void)insertEmotion:(Emotion *)emotion{
 
    
    //insertText 将文字插入到光标所在的位置
    if (emotion.png) {
        
        UIImage *image = [UIImage imageNamed:emotion.png];
        
        NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc]init];
        //拼接之前的文字，（图片和普通文字）
        [attrText appendAttributedString:self.attributedText];
        
        //加上图片
        NSTextAttachment *attch = [NSTextAttachment new];
        attch.image = image;
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -3, attchWH, attchWH);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        
        NSUInteger loc = self.selectedRange.location;
        //加到光标所在位置的后面
        [attrText insertAttributedString:imageStr atIndex:loc];
        //[attrText appendAttributedString:imageStr];
        
        [attrText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,attrText.length)];
        
        self.attributedText = attrText;//光标会自动移到最后
        
        //重新设置光标位置支插入表情的后面
        self.selectedRange = NSMakeRange(loc+1, 0);
        
        
    }else{
        [self insertText:emotion.code.emoji];
        
    }
}

@end
