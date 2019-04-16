//
//  GYNoticeViewCell.m
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GYNoticeViewCell.h"

@implementation GYNoticeViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        if (GYRollingDebugLog) {
            NSLog(@"init a cell from code: %p", self);
        }
        _textLabelLeading = 10;
        _textLabelTrailing = 10;
        _reuseIdentifier = reuseIdentifier;
        [self setupInitialUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        if (GYRollingDebugLog) {
            NSLog(@"init a cell from xib");
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithReuseIdentifier:@""];
}

- (void)setupInitialUI
{
    self.backgroundColor = [UIColor whiteColor];
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    _textLabel = [[UILabel alloc]init];
    [_contentView addSubview:_textLabel];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame = self.bounds;
    
    if (nil != _textLabel) {
        CGFloat lead = _textLabelLeading;
        if (lead < 0) {
            NSLog(@"⚠️⚠️textLabelLeading must >= 0⚠️⚠️");
            lead = 0;
        }
        CGFloat trai = _textLabelTrailing;
        if (trai < 0) {
            NSLog(@"⚠️⚠️textLabelTrailing must >= 0⚠️⚠️");
            trai = 0;
        }
        CGFloat width = self.frame.size.width - lead - trai;
        if (width < 0) {
            NSLog(@"⚠️⚠️width must >= 0⚠️⚠️");
            width = 0;
        }
        _textLabel.frame = CGRectMake(lead, 0, width, self.frame.size.height);
    }
    
    
}

- (void)dealloc
{
    if (GYRollingDebugLog) {
        NSLog(@"%p, %s", self, __func__);
    }
    
}


@end
