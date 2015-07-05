//
//  StatusFrame.m
//  YNWeiBo
//
//  Created by james on 15/7/5.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
// 

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"

#define IWstatusCellBorderW 10


@implementation StatusFrame

-(void)setStatus:(Status *)status{
    
    User *user = status.user;
    
    _status = status;
    CGFloat iconWH=35;
    CGFloat iconX = IWstatusCellBorderW;
    CGFloat iconY = IWstatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + IWstatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:IWstatusCellNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF)+IWstatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + IWstatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:IWstatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF)+IWstatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:IWstatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 2*IWstatusCellBorderW;
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+IWstatusCellBorderW;
    CGSize contentSize = [self sizeWithText:status.text font:IWstatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat origianH = 0;
    //有配图
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF)+IWstatusCellBorderW;
        CGFloat photoWH = 100;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        origianH = CGRectGetMaxY(self.photoViewF) +IWstatusCellBorderW;
    }else{
        origianH = CGRectGetMaxY(self.contentLabelF) +IWstatusCellBorderW;
    }
    
    
    CGFloat origianW = [UIScreen mainScreen].bounds.size.width;
    self.originalViewF = CGRectMake(0, 0, origianW, origianH);
    
    if (status.retweeted_status) {
        /** 被转发微博 */
        
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = IWstatusCellBorderW;
        CGFloat retweetContentY = IWstatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:IWstatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            CGFloat photoX = retweetContentX;
            CGFloat photoY = CGRectGetMaxY(self.retweetContentLabelF)+IWstatusCellBorderW;
            CGFloat photoWH = 100;
            self.retweetPhotoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF)+IWstatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF)+IWstatusCellBorderW;
        }
        
        self.retweetViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, retweetH);
        
        self.cellHeight = CGRectGetMaxY(self.retweetViewF);
        
    }else{
            self.cellHeight = CGRectGetMaxY(self.originalViewF);
    }

    

    
    
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    //return [text sizeWithAttributes:attrs];
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{

    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}


@end
