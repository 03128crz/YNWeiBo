//
//  Emotion.h
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject<NSCoding>

@property(nonatomic,copy)NSString *chs;
@property(nonatomic,copy)NSString *png;

/** emoji表情的16进制编码 */
@property(nonatomic,copy)NSString *code;

@end
