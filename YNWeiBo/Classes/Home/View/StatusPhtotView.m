//
//  StatusPhtotView.m
//  YNWeiBo
//
//  Created by james on 15/7/8.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "StatusPhtotView.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface StatusPhtotView ()
@property (weak, nonatomic) UIImageView *gifView;
@end

@implementation StatusPhtotView

-(UIImageView *)gifView{
    if (_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    
    return _gifView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        //按原来的宽高比，可以超出原来的尺寸
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框的内容都不显示
        self.clipsToBounds = YES;
    }
    // 凡是带Scale的图片都会拉伸
    // 凡是带Aspect，图片都会保持原来的宽高比，不会变形
    
//    UIViewContentModeScaleToFill, 图片拉伸至填充整个UIImageVIew（可能变形）
//    UIViewContentModeScaleAspectFit,图片拉伸至完全显示在UIImageView中（不会变形）
//    UIViewContentModeScaleAspectFill,拉伸到长度或高度在UIImage中为止，居中（不会变形，可能超出范围，左右或上下超出）     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//    UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//    UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
//    UIViewContentModeTop,
//    UIViewContentModeBottom,
//    UIViewContentModeLeft,
//    UIViewContentModeRight,
//    UIViewContentModeTopLeft,
//    UIViewContentModeTopRight,
//    UIViewContentModeBottomLeft,
//    UIViewContentModeBottomRight,
    
    return self;
}

-(void)setPhoto:(NSDictionary *)photo{
    _photo = photo;
    
    NSString *picUrl = photo[@"thumbnail_pic"];
    //NSLog(@"%@",picUrl);
   [self sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![picUrl.lowercaseString hasPrefix:@"gif"];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
