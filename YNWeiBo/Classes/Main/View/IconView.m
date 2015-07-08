//
//  IconView.m
//  YNWeiBo
//
//  Created by james on 15/7/8.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "IconView.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface IconView ()

@property (weak, nonatomic) UIImageView *verifiedView;

@end

@implementation IconView

-(UIImageView *)verifiedView{
    if (!_verifiedView) {
        UIImageView  *veriView = [UIImageView new];
        [self addSubview:veriView];
        _verifiedView = veriView;
    }
    
    return _verifiedView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        //
    }
    
    return self;
}

-(void)setUser:(User *)user{
    
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
//        case UserVerifiedTypeNone:
//            
//            self.verifiedView.hidden = YES;
//            break;
//            
        case UserVerifiedTypePersonal:
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            self.verifiedView.hidden = NO;
            break;
        case UserVerifiedTypeOrgEnterprice:
        case UserVerifiedTypeOrgMedia:
        case UserVerifiedTypeOrgWebsite:
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            self.verifiedView.hidden = NO;
            break;
        case UserVerifiedTypeDaren:
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            self.verifiedView.hidden = NO;
            break;

        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

//设置子控件尺寸
-(void)layoutSubviews{
    [super layoutSubviews];

    self.verifiedView.size = self.verifiedView.image.size;
    //有四分之三在外面
    self.verifiedView.x = self.width - self.verifiedView.width* 0.6;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.6;
}

@end
