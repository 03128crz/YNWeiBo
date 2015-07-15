//
//  Emotion.m
//  YNWeiBo
//
//  Created by james on 15/7/12.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "Emotion.h"
#import "MJExtension.h"

@implementation Emotion


//使用以下宏的话下面两个方法都可以不要了，已包含
//MJCodingImplementation

//从文件中解析对象时调用
-(id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
        
        //使用MJExtension
        //self
        
    }
    
    return self;
}

//将对象写入文件时调用
-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
    
}

@end
