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
#import "UITextView+Extension.h"
#import "EmotionAttachment.h"

@implementation EmotionTextView

-(void)insertEmotion:(Emotion *)emotion{
 
    if (emotion.png) {
        
        
        //加上图片
        EmotionAttachment *attch = [EmotionAttachment new];
        attch.emotion = emotion;
        
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -3, attchWH, attchWH);

        //根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        //插入属性文字到光标位置
        [self insertAttributeText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,attributedText.length)];
        }];
        
        //设置字体 报错
        //
        
    }else{
        //insertText 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
        
    }
}

-(NSString *)fullText{
    
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        EmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {//表情图片
            [fullText appendString:attch.emotion.chs];
        }else{
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
        
    }];
    
    return fullText;
    
}

@end
