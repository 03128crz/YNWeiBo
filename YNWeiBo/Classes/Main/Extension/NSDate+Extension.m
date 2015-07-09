//
//  NSDate+Extension.m
//  YNWeiBo
//
//  Created by james on 15/7/6.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

-(BOOL)isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return dateCmps.year ==nowCmps.year;
}

-(BOOL)isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *date  = [fmt dateFromString:dateStr];
    
    NSDate *now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.day==0 && cmps.month ==0 && cmps.day==1;
}

-(BOOL)isToday{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

@end
