//
//  StatusToolbar.m
//  YNWeiBo
//
//  Created by james on 15/7/5.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "StatusToolbar.h"
#import "UIView+Extension.h"
#import "Status.h"

@interface StatusToolbar()

@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)NSMutableArray *dividers;

@property(nonatomic,weak)UIButton *repostBtn;
@property(nonatomic,weak)UIButton *commentBtn;
@property(nonatomic,weak)UIButton *attitudeBtn;

@end

@implementation StatusToolbar

-(NSMutableArray *)btns{
    
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividers{
    
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+(instancetype)toolbar{
    
    
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        //拉伸平铺,使用背景图使上下有框
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //
        self.repostBtn = [self setupBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtnWithTitle:@"点赞" icon:@"timeline_icon_unlike"];
        
        [self setupDivider];
        [self setupDivider];
        
    }
    
    return self;
}

-(void)setupDivider{
    
    UIImageView *divider = [UIImageView new];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

-(UIButton *)setupBtnWithTitle:(NSString*)title icon:(NSString*)icon
{
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn  setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    int count = self.btns.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (int i=0; i<count; i++) {
        UIButton *btn = self.btns[i];
        btn.y=0;
        btn.width = btnW;
        btn.x = i*btnW;
        btn.height = btnH;
    }
    
    int dividerCount = self.dividers.count;
    for (int i=0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width  =1;
        divider.height = btnH;
        divider.x = (i+1)*btnW;
        divider.y = 0;
    }
}

-(void)setStatus:(Status *)status{
    _status = status;
    //转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发" ];
    
    //评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论" ];
    
    //表态
   [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"点赞" ];
    
    
}

-(void)setupBtnCount:(int)count btn:(UIButton*)btn title:(NSString *)title {
 
    if (count) {
        if (count<10000) {
            
            title =[NSString stringWithFormat:@"%d",count];
            
        }else{//达到10000以上,显示xx.x万，不要有.0的情况
            double wan = count/10000.0;
            title =[NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
    }
    [btn setTitle:title forState:UIControlStateNormal];
    
}

@end
