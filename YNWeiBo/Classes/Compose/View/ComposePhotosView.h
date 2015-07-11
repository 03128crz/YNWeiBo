//
//  ComposePhotosView.h
//  YNWeiBo
//
//  Created by james on 15/7/11.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposePhotosView : UIView

-(void)addPhoto:(UIImage *)photo;

//@property (strong, nonatomic,readonly) NSArray *photos;
-(NSArray *)photos;

@end
