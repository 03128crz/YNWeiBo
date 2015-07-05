//
//  StatusFrame.h
//  YNWeiBo
//
//  Created by james on 15/7/5.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IWstatusCellNameFont  [UIFont systemFontOfSize:15]
#define IWstatusCellTimeFont  [UIFont systemFontOfSize:12]
#define IWstatusCellSourceFont  [UIFont systemFontOfSize:12]
#define IWstatusCellContentFont  [UIFont systemFontOfSize:14]

@class Status;
@class User;
@interface StatusFrame : NSObject

@property(nonatomic,strong)Status *status;

/** 原创微博 */
@property(nonatomic,assign) CGRect originalViewF;
/** 头像 */
@property(nonatomic,assign) CGRect iconViewF;
/** vip图标 */
@property(nonatomic,assign) CGRect vipViewF;
/** 配图 */
@property(nonatomic,assign) CGRect photoViewF;
/** 呢称 */
@property(nonatomic,assign) CGRect nameLabelF;
/** 时间 */
@property(nonatomic,assign) CGRect timeLabelF;
/** 来源 */
@property(nonatomic,assign) CGRect sourceLabelF;
/** 内容*/
@property(nonatomic,assign) CGRect contentLabelF;

@property(nonatomic,assign)CGFloat cellHeight;

@end
