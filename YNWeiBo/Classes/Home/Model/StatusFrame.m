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
#import "StausPhotosView.h"

#define IWstatusCellBorderW 10
#define IWstatusCellMargin 15


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
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF)+IWstatusCellBorderW;
        CGSize photosSize = [StausPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX,photosY},photosSize};
        origianH = CGRectGetMaxY(self.photosViewF) +IWstatusCellBorderW;
    }else{
        origianH = CGRectGetMaxY(self.contentLabelF) +IWstatusCellBorderW;
    }
    
    
    CGFloat origianW = [UIScreen mainScreen].bounds.size.width;
    self.originalViewF = CGRectMake(0, IWstatusCellMargin, origianW, origianH);
    
    CGFloat toolbarY =0;
    /** 被转发微博 */
    if (status.retweeted_status) {
        
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = IWstatusCellBorderW;
        CGFloat retweetContentY = IWstatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:IWstatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            CGFloat photosX = retweetContentX;
            CGFloat photosY = CGRectGetMaxY(self.retweetContentLabelF)+IWstatusCellBorderW;
            CGSize photosSize = [StausPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            //self.retweetPhotosViewF = CGRectMake(photosX, photosY, photosWH, photosWH);
            self.retweetContentLabelF = (CGRect){{photosX,photosY},photosSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF)+IWstatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF)+IWstatusCellBorderW;
        }
        
        self.retweetViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
        
    }else{
       toolbarY = CGRectGetMaxY(self.originalViewF);
    }

    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toobarH = 35;
    
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toobarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
    
    
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
