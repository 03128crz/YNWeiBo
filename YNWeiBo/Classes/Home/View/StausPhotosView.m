//
//  StausPhotosView.m
//  YNWeiBo
//
//  Created by james on 15/7/7.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "StausPhotosView.h"
#import "Photo.h"
#import "UIView+Extension.h"
#import "StatusPhtotView.h"

#define StatusPhtotMargin 10
#define StatusPhtotWH 70

@implementation StausPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //
    }
    
    return self;
}

//调用非常频繁。tableview滚动
-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    
    //循环利用内部的imageView
    if (self.subviews.count>=photos.count) {
        
        
    }else{
        while (self.subviews.count<photos.count) {
            StatusPhtotView *photoView= [[StatusPhtotView alloc]init];
            [self addSubview:photoView];
        }
    }
 
    for (NSInteger i = 0; i<self.subviews.count; i++) {
        StatusPhtotView *photoView = self.subviews[i];

        if (i<photos.count) {//显示
            
            photoView.photo = photos[i];

            photoView.hidden = NO;
        }else{
            photoView.hidden  =YES;
        }
        
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    for (int i =0; i<self.photos.count; i++) {
        StatusPhtotView *photoView = self.subviews[i];
        
        int col = i%3;
        
        photoView.x = col *(StatusPhtotWH + StatusPhtotMargin);
        
        int row = i/3;
        
        photoView.y = row *(StatusPhtotWH + StatusPhtotMargin);
        
        photoView.width = StatusPhtotWH;
        photoView.height =StatusPhtotWH;
        
    }
    
}

+(CGSize)sizeWithCount:(NSInteger)count{
    
    NSInteger maxCols = 3;
    
    //列数
    NSInteger cols = (count>=maxCols) ? maxCols : count;
    
    CGFloat photosW = cols * StatusPhtotWH +(cols-1)*StatusPhtotMargin;
    
    //行数
    
    //    NSInteger rows = 0;
    //    if (count%3==0) {
    //        rows = count/3;
    //    }else{
    //        rows = count/3+1;
    //    }
    
    //    NSInteger rows = count/3;
    //    if (count%3!=0) {
    //        rows +=1;
    //    }
    
    NSInteger rows = (count + maxCols -1)/maxCols;
    
    CGFloat photosH = rows * StatusPhtotWH +(rows-1)*StatusPhtotMargin;
    
    return CGSizeMake(photosW, photosH);
    
    
}

@end
