//
//  ComposeToolbar.h
//  YNWeiBo
//
//  Created by james on 15/7/10.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ComposeToolbarButtonTypeCamera,
    ComposeToolbarButtonTypePicture,
    ComposeToolbarButtonTypeEmotion,
    ComposeToolbarButtonTypeMention,
    ComposeToolbarButtonTypeTrend
} ComposeToolbarButtonType;


@class ComposeToolbar;
@protocol ComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(ComposeToolbar *)toolbar didClickButton:(ComposeToolbarButtonType)buttonType;
@end

@interface ComposeToolbar : UIView
@property (weak, nonatomic) id<ComposeToolbarDelegate> delegate;

@property(nonatomic,assign)BOOL showKeyboardButton;

@end
