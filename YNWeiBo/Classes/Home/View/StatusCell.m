//
//  StatusCell.m
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "StatusCell.h"
#import "StatusFrame.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "Status.h"
#import "UIView+Extension.h"
#import "StatusToolbar.h"
#import "StausPhotosView.h"

@interface StatusCell ()
/** 原创微博 */
@property(nonatomic,weak)UIView *originalView;
/** 头像 */
@property(nonatomic,weak)UIImageView *iconView;
/** vip图标 */
@property(nonatomic,weak)UIImageView *vipView;
/** 配图 */
@property(nonatomic,weak)StausPhotosView *photosView;
/** 呢称 */
@property(nonatomic,weak)UILabel *nameLabel;
/** 时间 */
@property(nonatomic,weak)UILabel *timeLabel;
/** 来源 */
@property(nonatomic,weak)UILabel *sourceLabel;
/** 内容*/
@property(nonatomic,weak)UILabel *contentLabel;

/** 转发微博 */
@property(nonatomic,weak)UIView *retweetView;
/** 转发微博内容+呢称*/
@property(nonatomic,weak)UILabel *retweetContentLabel;
@property(nonatomic,weak)StausPhotosView *retweetPhotosView;

/** 工具条 */
@property (nonatomic,weak)StatusToolbar *toolbar;

@end

@implementation StatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //点击cell不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        //原创微博整体
        [self setupOriginal];
        
        //转发微博
        [self setupRetweet];
        
        [self setupToolbar];
        
    }
    
    return self;
}

//-(void)setFrame:(CGRect)frame{
//    frame.origin.y +=15;
//    [super setFrame:frame];
//}

-(void)setupToolbar{
    
    StatusToolbar *toolbar = [StatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setupRetweet{
    UIView *retweetView = [UIView new];
    retweetView.backgroundColor = [UIColor colorWithRed:(247)/255.0 green:(247)/255.0 blue:(247)/255.0 alpha:1.0];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentLabel = [UILabel new];
    retweetContentLabel.font = IWstatusCellRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    StausPhotosView *retweetPhotosView = [StausPhotosView new];
    [self.retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

-(void)setupOriginal{
    UIView *originalView = [UIView new];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    UIImageView *iconView = [UIImageView new];
    [self.originalView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *viplView = [UIImageView new];
    viplView.contentMode =UIViewContentModeCenter;
    [self.originalView addSubview:viplView];
    self.vipView = viplView;
    
    StausPhotosView *photosView = [StausPhotosView new];
    [self.originalView addSubview:photosView];
    self.photosView = photosView;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = IWstatusCellNameFont;
    [self.originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = IWstatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [UILabel new];
    sourceLabel.font = IWstatusCellSourceFont;
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.font = IWstatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [self.originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    
    _statusFrame  = statusFrame;
    
    Status *status = statusFrame.status;
    User *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewF;
    
    self.iconView.frame =statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image =[UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
        
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    

    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        
        self.photosView.photos = status.pic_urls;
        
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }

    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    /** 被转发微博整体 */
    if (status.retweeted_status) {
        
        Status *retweeted_status = status.retweeted_status;
        User *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;

            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;

        }else{
            self.retweetPhotosView.hidden  =YES;
        }
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
    
}



@end
