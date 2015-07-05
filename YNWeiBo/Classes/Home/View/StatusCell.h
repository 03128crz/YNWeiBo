//
//  StatusCell.h
//  YNWeiBo
//
//  Created by james on 15/7/4.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusFrame;

@interface StatusCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)StatusFrame *statusFrame;

@end
