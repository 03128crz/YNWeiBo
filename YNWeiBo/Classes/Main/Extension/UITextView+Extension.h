//
//  UITextView+Extension.h
//  YNWeiBo
//
//  Created by james on 15/7/13.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)text;

-(void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
