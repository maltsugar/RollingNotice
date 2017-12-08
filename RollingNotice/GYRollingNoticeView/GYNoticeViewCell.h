//
//  GYNoticeViewCell.h
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYNoticeViewCell : UIView

@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, readonly, strong) UILabel *textLabel;
@property (nonatomic, readonly,   copy) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end
