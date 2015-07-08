//
//  Status.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"
#import "Photo.h"
#import "NSDate+Extension.h"

@implementation Status

-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[Photo class]};
}

//来源不变，用set
-(void)setSource:(NSString *)source{
    
    NSRange range;
    
    range.location = [source rangeOfString:@">"].location +1;
    
    range.length = [source rangeOfString:@"</"].location - range.location;
    
    _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
    
}

//显示的时间时时变，用get
-(NSString *)created_at{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    // 日历对象，方便比较两个日期之间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
   //想要获取的差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ( createDate.isThisYear) {
        if (createDate.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if(createDate.isToday){
            if (components.hour>=1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)components.hour];
            }else if (components.minute>=1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)components.minute];
            }else{
                return @"刚刚";
            }
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [ fmt stringFromDate:createDate];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
    //fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
}



@end
