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

@interface StatusCell ()
/** 原创微博 */
@property(nonatomic,weak)UIView *originalView;
/** 头像 */
@property(nonatomic,weak)UIImageView *iconView;
/** vip图标 */
@property(nonatomic,weak)UIImageView *vipView;
/** 配图 */
@property(nonatomic,weak)UIImageView *photoView;
/** 呢称 */
@property(nonatomic,weak)UILabel *nameLabel;
/** 时间 */
@property(nonatomic,weak)UILabel *timeLabel;
/** 来源 */
@property(nonatomic,weak)UILabel *sourceLabel;
/** 内容*/
@property(nonatomic,weak)UILabel *contentLabel;


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
        //原创微博整体
        
        UIView *originalView = [UIView new];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        UIImageView *iconView = [UIImageView new];
        [self.originalView addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView *viplView = [UIImageView new];
        viplView.contentMode =UIViewContentModeCenter;
        [self.originalView addSubview:viplView];
        self.vipView = viplView;
        
        UIImageView *photoView = [UIImageView new];
        [self.originalView addSubview:photoView];
        self.photoView = photoView;
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.font = IWstatusCellNameFont;
        [self.originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *timeLabel = [UILabel new];
        timeLabel.font = IWstatusCellTimeFont;
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
    
    return self;
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
        self.photoView.frame = statusFrame.photoViewF;
        //NSLog(@"%@",status.pic_urls);
        NSDictionary *photo =[status.pic_urls lastObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo[@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }

    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;

    
}



@end
