//
//  ComposePhotosView.m
//  YNWeiBo
//
//  Created by james on 15/7/11.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "ComposePhotosView.h"
#import "UIView+Extension.h"

@interface ComposePhotosView ()
@property (weak, nonatomic) NSMutableArray *addedPhotos;
@end

@implementation ComposePhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _addedPhotos = [NSMutableArray array];
    }
    
    return self;
}

-(void)addPhoto:(UIImage *)photo{
    
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    [self.addedPhotos  addObject:photo];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageMargin = 10;
    
    CGFloat imageWH = 70;
    
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i%maxCol;
        photoView.x = col *(imageMargin +imageWH);
        
        int row = i/maxCol;
        photoView.y = row *(imageWH +imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}

-(NSArray *)photos{
    
    return self.addedPhotos;
}

@end
