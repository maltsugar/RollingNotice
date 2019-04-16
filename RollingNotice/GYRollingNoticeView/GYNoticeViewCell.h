//
//  GYNoticeViewCell.h
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>

// 调试cell内存地址log
static BOOL GYRollingDebugLog = NO;

@interface GYNoticeViewCell : UIView

@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, readonly, strong) UILabel *textLabel;
@property (nonatomic, readonly,   copy) NSString *reuseIdentifier;


/// 普通用法label，左右间距， 必须>=0, 默认10
@property (nonatomic, assign) CGFloat textLabelLeading;
@property (nonatomic, assign) CGFloat textLabelTrailing;


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end
